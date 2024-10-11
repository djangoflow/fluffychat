import 'package:fluffychat/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FluffyChatAppBootstrapper {
  FluffyChatAppBootstrapper._();

  static Future<Widget?> bootstrapAndGetApp(
    FluffyChatBootstrapConfig config,
  ) async {
    Logs().i('Welcome to ${AppConfig.applicationName} <3');

    // Our background push shared isolate accesses flutter-internal things very early in the startup proccess
    // To make sure that the parts of flutter needed are started up already, we need to ensure that the
    // widget bindings are initialized already.
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize global config
    GlobalConfig.init(isPackage: true, config: config);
    if (config.appConfigUpdate != null) {
      AppConfig.updateConfig(
        update: config.appConfigUpdate!,
        productionUpdate: config.productionConfigUpdate,
        sandboxUpdate: config.sandboxConfigUpdate,
      );
    }
    if (config.routes != null) {
      FluffyChatApp.routes = config.routes!();
    }

    Logs().nativeColors = !PlatformInfos.isIOS;
    final store = await SharedPreferences.getInstance();
    final clients = await ClientManager.getClients(store: store);

    // If the app starts in detached mode, we assume that it is in
    // background fetch mode for processing push notifications. This is
    // currently only supported on Android.
    if (PlatformInfos.isAndroid &&
        AppLifecycleState.detached == WidgetsBinding.instance.lifecycleState) {
      // Do not send online presences when app is in background fetch mode.
      for (final client in clients) {
        client.backgroundSync = false;
        client.syncPresence = PresenceType.offline;
      }

      // In the background fetch mode we do not want to waste ressources with
      // starting the Flutter engine but process incoming push notifications.
      BackgroundPush.clientOnly(clients.first);
      // To start the flutter engine afterwards we add an custom observer.
      WidgetsBinding.instance.addObserver(AppStarter(clients, store));
      Logs().i(
        '${AppConfig.applicationName} started in background-fetch mode. No GUI will be created unless the app is no longer detached.',
      );
      return null;
    }

    // Started in foreground mode.
    Logs().i(
      '${AppConfig.applicationName} started in foreground mode. Rendering GUI...',
    );
    return await _startGui(clients, store);
  }

  /// Fetch the pincode for the applock and start the flutter engine.
  static Future<Widget> _startGui(
    List<Client> clients,
    SharedPreferences store,
  ) async {
    // Fetch the pin for the applock if existing for mobile applications.
    String? pin;
    if (PlatformInfos.isMobile) {
      try {
        pin = await const FlutterSecureStorage()
            .read(key: SettingKeys.appLockKey);
      } catch (e, s) {
        Logs().d('Unable to read PIN from Secure storage', e, s);
      }
    }

    // Preload first client
    final firstClient = clients.firstOrNull;
    await firstClient?.roomsLoading;
    await firstClient?.accountDataLoading;

    ErrorWidget.builder = (details) => FluffyChatErrorWidget(details);
    return FluffyChatApp(
      clients: clients,
      pincode: pin,
      store: store,
      config: GlobalConfig.bootstrapConfig,
    );
  }
}

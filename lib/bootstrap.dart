import 'package:fluffychat/config/app_config_update.dart';
import 'package:fluffychat/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void bootstrapFluffyChatApp({
  required FluffyChatBootstrapConfig config,
}) async {
  GlobalConfig.bootstrapConfig = config;
  if (config.appConfigUpdate != null) {
    AppConfig.updateConfig(update: config.appConfigUpdate!);
  }
  if (config.routes != null) {
    FluffyChatApp.routes = config.routes!();
  }
  main();
}

class FluffyChatBootstrapConfig {
  final ThemeData Function(BuildContext, Brightness, Color? seedColor)?
      themeBuilder;
  final List<RouteBase> Function()? routes;
  final AppConfigUpdate? appConfigUpdate;

  FluffyChatBootstrapConfig({
    this.themeBuilder,
    this.routes,
    this.appConfigUpdate,
  });
}

class GlobalConfig {
  static FluffyChatBootstrapConfig? bootstrapConfig;
}

import 'package:fluffychat/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void bootstrapFluffyChat({
  required FluffyChatBootstrapConfig config,
}) async {
  GlobalConfig.bootstrapConfig = config;
  if (config.routes != null) {
    FluffyChatApp.routes = config.routes!();
  }
  main();
}

class FluffyChatBootstrapConfig {
  final ThemeData Function(BuildContext, Brightness, Color? seedColor)?
      themeBuilder;
  final List<RouteBase> Function()? routes;

  FluffyChatBootstrapConfig({
    this.themeBuilder,
    this.routes,
  });
}

class GlobalConfig {
  static FluffyChatBootstrapConfig? bootstrapConfig;
}

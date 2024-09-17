import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_config_update.dart';

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

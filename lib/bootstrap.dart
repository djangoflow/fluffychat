import 'package:fluffychat/lib.dart';

void bootstrapFluffyChatApp({
  required FluffyChatBootstrapConfig config,
}) async {
  GlobalConfig.init(isPackage: true, config: config);
  if (config.appConfigUpdate != null) {
    AppConfig.updateConfig(update: config.appConfigUpdate!);
  }
  if (config.routes != null) {
    FluffyChatApp.routes = config.routes!();
  }
  main();
}

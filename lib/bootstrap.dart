import 'package:fluffychat/lib.dart';

import 'config/bootstrap_config.dart';
import 'config/global_config.dart';

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

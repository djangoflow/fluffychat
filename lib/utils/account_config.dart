import 'package:matrix/matrix.dart';

import '../config/app_config.dart';

extension ApplicationAccountConfigExtension on Client {
  static final String accountDataKey = '${AppConfig.clientId}.account_config';

  ApplicationAccountConfig get applicationAccountConfig =>
      ApplicationAccountConfig.fromJson(
        accountData[accountDataKey]?.content ?? {},
      );

  Future<void> setApplicationAccountConfig(
    ApplicationAccountConfig config,
  ) =>
      setAccountData(
        userID!,
        accountDataKey,
        config.toJson(),
      );

  /// Only updates the specified values in ApplicationAccountConfig
  Future<void> updateApplicationAccountConfig(
    ApplicationAccountConfig config,
  ) {
    final currentConfig = applicationAccountConfig;
    return setAccountData(
      userID!,
      accountDataKey,
      ApplicationAccountConfig(
        wallpaperUrl: config.wallpaperUrl ?? currentConfig.wallpaperUrl,
        wallpaperOpacity:
            config.wallpaperOpacity ?? currentConfig.wallpaperOpacity,
      ).toJson(),
    );
  }
}

class ApplicationAccountConfig {
  final Uri? wallpaperUrl;
  final double? wallpaperOpacity;

  const ApplicationAccountConfig({
    this.wallpaperUrl,
    this.wallpaperOpacity,
  });

  static double _sanitizedOpacity(double? opacity) {
    if (opacity == null) return 1;
    if (opacity > 1 || opacity < 0) return 1;
    return opacity;
  }

  factory ApplicationAccountConfig.fromJson(Map<String, dynamic> json) =>
      ApplicationAccountConfig(
        wallpaperUrl: json['wallpaper_url'] is String
            ? Uri.tryParse(json['wallpaper_url'])
            : null,
        wallpaperOpacity:
            _sanitizedOpacity(json.tryGet<double>('wallpaper_opacity')),
      );

  Map<String, dynamic> toJson() => {
        'wallpaper_url': wallpaperUrl?.toString(),
        'wallpaper_opacity': wallpaperOpacity,
      };
}

import 'bootstrap_config.dart';

class GlobalConfig {
  // Existing fields
  static FluffyChatBootstrapConfig? _bootstrapConfig;

  // New fields for asset management
  static bool _isPackage = false;
  static const String packageName = 'fluffychat';

  // Initialize the configuration
  static void init({
    required bool isPackage,
    FluffyChatBootstrapConfig? config,
  }) {
    _isPackage = isPackage;

    _bootstrapConfig = config;
  }

  static FluffyChatBootstrapConfig? get bootstrapConfig => _bootstrapConfig;

  // Asset resolution method
  static String resolveAssetPath(String assetPath) {
    return _isPackage ? 'packages/$packageName/$assetPath' : assetPath;
  }

  // Method to check if running as a package
  static bool get isPackage => _isPackage;

  // You can add more configuration getters and setters here as needed
}

// Extension method for easy asset path resolution
extension AssetPathResolution on String {
  String get resolveAssetPath => GlobalConfig.resolveAssetPath(this);
}

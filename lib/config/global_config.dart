import 'bootstrap_config.dart';

class GlobalConfig {
  // Existing fields
  static FluffyChatBootstrapConfig? _bootstrapConfig;

  // New fields for asset management
  static bool _isPackage = false;
  static String _packageName = 'fluffychat';

  // Initialize the configuration
  static void init({
    required bool isPackage,
    String packageName = 'fluffychat',
    FluffyChatBootstrapConfig? config,
  }) {
    _isPackage = isPackage;
    _packageName = packageName;
    _bootstrapConfig = config;
  }

  static FluffyChatBootstrapConfig? get bootstrapConfig => _bootstrapConfig;

  // Asset resolution method
  static String resolveAssetPath(String assetPath) {
    return _isPackage ? 'packages/$_packageName/$assetPath' : assetPath;
  }

  // Method to get the package name (useful for other package-related operations)
  static String get packageName => _packageName;

  // Method to check if running as a package
  static bool get isPackage => _isPackage;

  // You can add more configuration getters and setters here as needed
}

// Extension method for easy asset path resolution
extension AssetPathResolution on String {
  String get resolveAssetPath => GlobalConfig.resolveAssetPath(this);
}

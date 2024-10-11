class EnvironmentConfig {
  final String defaultHomeserver;
  final String? defaultSSOProvider;
  final String? ssoClientId;
  final String odooBaseUrl;
  final String odooState;

  EnvironmentConfig({
    required this.defaultHomeserver,
    this.defaultSSOProvider,
    this.ssoClientId,
    required this.odooBaseUrl,
    required this.odooState,
  });
}

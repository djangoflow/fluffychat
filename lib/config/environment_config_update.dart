class EnvironmentConfigUpdate {
  final String? defaultHomeserver;
  final String? defaultSSOProvider;
  final String? ssoClientId;
  final String? odooBaseUrl;
  final String? odooState;

  EnvironmentConfigUpdate({
    this.defaultHomeserver,
    this.defaultSSOProvider,
    this.ssoClientId,
    this.odooBaseUrl,
    this.odooState,
  });
}

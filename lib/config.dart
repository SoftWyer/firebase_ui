abstract class Config {}

class AppleConfig extends Config {
  /// The redirect path used by Apple
  final String redirectPath;

  /// The scheme, e.g. HTTPS
  final String scheme;

  /// The host that authenticates, e.g. the Glitch server name hosting the code
  final String host;

  /// The path used to start authentication
  final String path;

  /// The client ID used to identify us with Apple
  final String clientId;

  AppleConfig(this.scheme, this.host, this.path, this.redirectPath, this.clientId);

  static String get configName => 'AppleConfig';
}

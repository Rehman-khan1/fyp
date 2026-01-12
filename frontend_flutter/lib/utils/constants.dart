class BackendConfig {
  // Set API_BASE_URL at build/run time with --dart-define=API_BASE_URL="http://<host>:<port>"
  // Defaults to the local development IP used in this project.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.10.8:8000',
  );
}

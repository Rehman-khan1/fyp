import 'package:flutter/foundation.dart' show kIsWeb;
import 'backend_config_io.dart'
    if (dart.library.html) 'backend_config_web.dart';

class BackendConfig {
  // Compile-time override with --dart-define=API_BASE_URL="http://host:port"
  static const String _define = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static String get baseUrl {
    if (_define.isNotEmpty) return _define;
    return platformDefaultBaseUrl();
  }
}

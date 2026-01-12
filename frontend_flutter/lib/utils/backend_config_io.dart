// This implementation is used when dart:html is NOT available (mobile/desktop).
import 'dart:io' show Platform;

String platformDefaultBaseUrl() {
  if (Platform.isAndroid) {
    // Android emulator -> host machine
    return 'http://10.0.2.2:8000';
  }
  if (Platform.isIOS) {
    // iOS simulator uses localhost
    return 'http://localhost:8000';
  }
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    return 'http://localhost:8000';
  }
  // Fallback to a network IP if nothing matches
  return 'http://192.168.10.8:8000';
}

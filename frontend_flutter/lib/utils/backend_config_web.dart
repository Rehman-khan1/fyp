// This implementation is used when dart:html is available (web).
import 'dart:html' as html;

String platformDefaultBaseUrl() {
  final loc = html.window.location;
  // If the web app is served without a port (e.g. github pages), assume backend on :8000
  if (loc.port == null || loc.port.isEmpty) {
    return '${loc.protocol}//${loc.hostname}:8000';
  }
  // If served with a port, assume backend is reachable at the same origin
  return loc.origin;
}

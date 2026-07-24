abstract interface class OcppClient{
Future<void> connect();
Future<void> startSession(String chargerId);
Future<void> stopSession(String sessionId);
}
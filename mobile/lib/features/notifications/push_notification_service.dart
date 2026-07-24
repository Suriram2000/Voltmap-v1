abstract interface class PushNotificationService{
Future<void> initialize();
Future<void> subscribeToUser(String id);
Future<void> sendLocal(String title,String body);
}
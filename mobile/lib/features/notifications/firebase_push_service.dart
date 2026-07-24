import 'push_notification_service.dart';
class FirebasePushService implements PushNotificationService{
const FirebasePushService();
Future<void> initialize() async{}
Future<void> subscribeToUser(String id) async{}
Future<void> sendLocal(String t,String b) async{}
}
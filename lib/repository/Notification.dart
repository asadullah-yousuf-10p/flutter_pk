import 'package:chopper/chopper.dart';
import 'package:flutter_pk/helpers/ApiKey.dart';

part 'Notification.chopper.dart';

@ChopperApi(baseUrl: '/fcm/send')
abstract class NotificationSend extends ChopperService with ApiKey {
  static NotificationSend create() {
    final client = ChopperClient(
        baseUrl: 'https://fcm.googleapis.com',
        services: [
          _$NotificationSend(),
        ],
        converter: JsonConverter(),
        errorConverter: JsonConverter());
    return _$NotificationSend(client);
  }

  @Post(headers: {
    'content-type': 'application/json',
    'Authorization': ApiKey.apiKey
  })
  Future<Response> sendNotification(
    @Body() Map<String, dynamic> body,
  );
}

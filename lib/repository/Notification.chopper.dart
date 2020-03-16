// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notification.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$NotificationSend extends NotificationSend {
  _$NotificationSend([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NotificationSend;

  @override
  Future<Response> sendNotification(Map<String, dynamic> body) {
    final $url = '/fcm/send';
    final $headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAARmeCefg:APA91bGOQ5Fe5wZL81HiBnyiRIMFpFwYYvdMxehIjMUtEMxGLg8vtxU7M2n2xRlsnK9YBRVCVfzX64b1KTk0txyTsXhwln6vKBMIJL9WhE6CPWKpsdXs2wa6q4GHcKlpw2pWYXTO2PaC'
    };
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}

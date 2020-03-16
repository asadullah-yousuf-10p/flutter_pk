import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_pk/repository/ImageRepo.dart';
import 'package:flutter_pk/repository/Notification.dart';
import './bloc.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final ImageRepo _imageRepo;

  ImageUploadBloc({ImageRepo imageRepo})
      : assert(imageRepo != null),
        _imageRepo = imageRepo;

  @override
  ImageUploadState get initialState => InitialImageUploadState();

  @override
  Stream<ImageUploadState> mapEventToState(ImageUploadEvent event) async* {
    if (event is UploadImage) {
      Map<String, dynamic> body = {
        "to": "/topics/wtq",
        "notification": {
          "body": event.body,
          "content_available": true,
          "priority": "high",
          "title": event.title,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'sound':'default'
        },
      };
      try {
        _imageRepo.uploadImage(
            event.image, event.num, event.context, event.title, event.body);

        await NotificationSend.create().sendNotification(body);

        yield SendNotificationImageState();
      } catch (error) {
        print(error);
        yield ErrorImageState();
      }
    }
  }
}

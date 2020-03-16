import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageUploadEvent {}

class UploadImage extends ImageUploadEvent {
  final File image;
  final int num;
  final BuildContext context;
  final String title;
  final String body;

  UploadImage(
      {@required this.image,
      @required this.num,
      this.context,
      this.title,
      this.body});
}

class GetImage extends ImageUploadEvent {
  final int num;

  GetImage({@required this.num});
}

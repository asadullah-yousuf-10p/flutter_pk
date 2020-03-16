import 'package:meta/meta.dart';

@immutable
abstract class ImageUploadState {}

class InitialImageUploadState extends ImageUploadState {}


class SendNotificationImageState extends ImageUploadState{}

class ErrorImageState extends ImageUploadState{}

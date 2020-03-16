import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/repository/Repository.dart';

class ImageRepo {
  StorageReference reference;
  Repository repository;

  Future<void> uploadImage(File image, int num, BuildContext context,
      String title, String body) async {
    reference =
        FirebaseStorage.instance.ref().child('gallery').child('Image$num');
    repository = Repository();
    if (image == null) {
      //createSnackBar('Please Select an image', Colors.redAccent);
    } else {
      StorageUploadTask task = reference.putFile(image);

      task.onComplete.then((url) async {
        String imageUrl = await url.ref.getDownloadURL();
        repository.addData(title, body, imageUrl);
        Navigator.pop(context);
      });

      //var dowUrl = await (await task.onComplete).ref.getDownloadURL();
      //print(dowUrl.toString());

//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => SendMessage(
//            imageUrl: dowUrl.toString(),
//            imageId: num,
//            title: title,
//            body: body,
//          ),
//        ),
//      );
    }
  }

  Future<String> getUploadedImage(int num) async {
    reference =
        FirebaseStorage.instance.ref().child('gallery').child('Image$num');
    return await reference.getDownloadURL();
  }
}

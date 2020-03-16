import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/shared_preferences.dart';
import 'package:flutter_pk/models/messages/MessagesModel.dart';
import 'package:flutter_pk/models/user/UserModel.dart';
import 'package:flutter_pk/profile/model.dart';

class Repository {
  SharedPreferencesHandler preferences = SharedPreferencesHandler();

  Future<void> addData(String title, String body, String imageUrl) async {
    var userId =
        await preferences.getValue(SharedPreferencesKeys.firebaseUserId);
    User _user = await userCache.getUser(userId);

    UserModel userModel = UserModel(
        id: _user.id,
        name: _user.name,
        email: _user.email,
        mobileNumber: _user.mobileNumber,
        photoUrl: _user.photoUrl);

    MessageModel messageModel = MessageModel(
        id: '',
        date: DateTime.now(),
        title: title,
        text: body,
        user: userModel,
        imageUrl: imageUrl);

    Firestore.instance
        .collection(
            '${FireStoreKeys.eventCollection}/women_tech_quest/${FireStoreKeys.messageCollection}')
        .add(
          jsonDecode(
            jsonEncode(messageModel),
          ),
        );

    Firestore.instance
        .collection(
            '${FireStoreKeys.eventCollection}/women_tech_quest/${FireStoreKeys.notificationUpdate}')
        .document('date')
        .setData({'date': DateTime.now().toString()});
  }
}

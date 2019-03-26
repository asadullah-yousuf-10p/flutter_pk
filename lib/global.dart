import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/caches/EventDate.dart';
import 'package:flutter_pk/caches/location.dart';
import 'package:flutter_pk/caches/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Routes {
  static const String home_master = '/home_master';
  static const String main = '/main';
}

abstract class GlobalConstants {
  static const int phoneNumberMaxLength = 13;
  static const int userNameMaxLength = 25;
  static const int emailMaxLength = 50;
  static const String breakId = 'break';
  static const int entryMaxLength = 50;
  static const String qrKey = "thisisahighlyencryptedaubykhanstringthatisbeingusedforfluttermeetupqrscan";
  static const String addNumberDisplayText =
      'Add your phone number in order to receive event updates.';
  static const String editNumberDisplayText =
      'Looks like you have a number registered against your account. You can use the same number to receive event confirmations or you can update it.';
  static const String wtqImportantNotes = '10Pearls University presents Women Tech Quest 2019 on 20th April\'19! \n\n Details to Note: \n\n • This event is exclusively for women\n • Timings: 09:30 AM to 04:00 PM \n • Location: 10Pearls University premises (8th floor, Parsa Towers, Shahrah-e-Faisal, Karachi)\n \n Participation Notes:\n\n  • Languages for Coding Competition: C#, C++, Java8, Javascript (Node.js), Objective-C, PHP, Ruby, Python 3, Golang\n • Languages & Tools for Testing Competition: Java , C# , C++\n • Tools for Design Competition:\n • Participants are expected to bring their laptops and chargers for the competition\n • Experienced professionals are encouraged to participate\n • Shortlisted individuals will be sent a confirmation email\n • Registration Deadline: 6th April \'19, 5 PM\n \n For queries/suggestions:\n Please email at university@10pearls.com';

}

abstract class SharedPreferencesKeys {
  static const String firebaseUserId = 'uid';
}

abstract class FireStoreKeys {
  static const String userCollection = 'users';
  static const String dateCollection = 'dates';
  static const String sessionCollection = 'sessions';
  static const String speakerCollection = 'speakers';
  static const String attendanceCollection = 'attendance';
  static const String attendeesCollection = 'attendees';
  static const String dateReferenceString = '16032019';
}

abstract class ColorDictionary {
  static const Map<String, Color> stringToColor = {
    'indigo': Colors.indigo,
    'green': Colors.green,
    'amber': Colors.amber,
    'blue': Colors.blue,
    'white': Colors.white,
    'black': Colors.black,
    'blueGrey': Colors.blueGrey,
    'lightBlue': Colors.lightBlue,
    'brown': Colors.brown,
    'teal': Colors.teal,
    'indigoAccent': Colors.indigoAccent,
    'grey': Colors.grey
  };
}

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();

UserCache userCache = new UserCache();

LocationCache locationCache = new LocationCache();

EventDateTimeCache eventDateTimeCache = new EventDateTimeCache();

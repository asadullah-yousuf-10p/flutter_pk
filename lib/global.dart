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
  static const int techStachMaxLength = 140;
  static const String qrKey =
      "thisisahighlyencryptedaubykhanstringthatisbeingusedforfluttermeetupqrscan";
  static const String addNumberDisplayText =
      'Add your phone number in order to receive event updates.';
  static const String editNumberDisplayText =
      'Looks like you have a number registered against your account. You can use the same number to receive event confirmations or you can update it.';
  static const String wtqImportantNotes =
      '10Pearls University presents Women Tech Quest 2019 on 20th April\'19! \n\n Details to Note: \n\n • This event is exclusively for women\n • Timings: 09:30 AM to 04:00 PM \n • Location: 10Pearls University premises (8th floor, Parsa Towers, Shahrah-e-Faisal, Karachi)\n \n Participation Notes:\n\n  • Languages for Coding Competition: C#, C++, Java8, Javascript (Node.js), Objective-C, PHP, Ruby, Python 3, Golang\n • Languages & Tools for Testing Competition: Java , C# , C++\n • Tools for Design Competition:\n • Participants are expected to bring their laptops and chargers for the competition\n • Experienced professionals are encouraged to participate\n • Shortlisted individuals will be sent a confirmation email\n • Registration Deadline: 6th April \'19, 5 PM\n \n For queries/suggestions:\n Please email at university@10pearls.com';
  static const String aboutWtqDetails =
      'Women Tech Quest is a competition that welcomes women from diverse tech backgrounds and experiences, encouraging them to exhibit their expertise by engaging in Software Coding, Testing and Web/Graphic Design competitions. This event aims to give professional women in tech a platform to engage with liked minded techie’s and also provide women on a career break a way to revisit and polish up their skill set.';
  static const String codingCompetitionDetails =
      'An exciting opportunity for all talented female developers to showcase their tech capabilities by making the best use of their coding and analytical skills. Win the competition by using any programming language to solve logical, algorithmic and data structure related challenges within a specified time limit.';
  static const String testingCompetitionDetails =
      'A thrilling opportunity for women testers to come at the forefront and unveil their testing skills by exposing them to several logical, automation and database related queries. Win the competition by identifying the gaps, refining the requirements and suggest enhancements for better user experience within a time frame.';
  static const String designCompetitionDetails =
      'An exhilarating competition for girls who are interested in Design. Bag a prize by creating an impactful Mini Campaign or designing an Experience for Web to showcase your skills in Visual Design. Select from a pre-defined set of concepts and pick your relevant challenge and win by displaying the best execution!';
  static const String prizeDetails =
      'Win Cash prizes up to Rs. 25,000!\nGrab swag kits, cool giveaways and certificates\nNetwork and share ideas with likeminded women\nOpportunity to meet mentors and professionals from industry';
  static const String guidelinesDetails =
      '• Once registered, shortlisted individuals will be sent a confirmation email\n• Participants are expected to bring their laptops and chargers for the competition\n • Pre-install Languages for Coding Competition: C#, C++, Java8, Javascript (Node.js), Objective-C, PHP, Ruby, Python 3, Golang\n • Pre-install Languages & Tools for Testing Competition: Java, C#, C++\n • Pres-install Tools for Design Competition:  Adobe Photoshop CS6 +, Adobe Illustrator CS6+, Axure RP 7+';
}

abstract class SharedPreferencesKeys {
  static const String firebaseUserId = 'uid';
}

abstract class FireStoreKeys {
  static const String userCollection = 'users';
  static const String dateCollection = 'dates';
  static const String sessionCollection = 'sessions';
  static const String sponsorsCollection = 'sponsors';
  static const String speakerCollection = 'speakers';
  static const String attendanceCollection = 'attendance';
  static const String attendeesCollection = 'attendees';
  static const String dateReferenceString = '16032019';
}

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();

UserCache userCache = new UserCache();

LocationCache locationCache = new LocationCache();

EventDateTimeCache eventDateTimeCache = new EventDateTimeCache();

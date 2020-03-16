import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/formatters.dart';
import 'package:flutter_pk/screens/apbar_widget/messages_board.dart';
import 'package:flutter_pk/provider/Preference.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WtqNotification extends StatelessWidget {
  final String id;

  //final String date;

  WtqNotification({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<Preference>(builder: (context, preference, child) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(
                '${FireStoreKeys.eventCollection}/women_tech_quest/${FireStoreKeys.notificationUpdate}')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String firebaseDate =
                snapshot.data.documents.first.data['date'].toString();
            //print(firebaseDate);

            //final preference = Provider.of<Preference>(context, listen: false);

            String date = preference.getStringValue();
            // print(date);

            DateTime firebase_date = DateTime.parse(firebaseDate);

            DateTime user_date = DateTime.parse(date);

            String formateFirebaseDate =
                formatDate(firebase_date, DateFormats.longUiTineFormat);
            String formateUserDate =
                formatDate(user_date, DateFormats.longUiTineFormat);



            if (DateTime.parse(formateFirebaseDate)
                .isBefore(DateTime.parse(formateUserDate))) {
              return WtqBadge(
                false,
                id: id,
              );
            } else if (DateTime.parse(formateFirebaseDate)
                .isAtSameMomentAs(DateTime.parse(formateUserDate))) {
              return WtqBadge(
                false,
                id: id,
              );
            } else if (DateTime.parse(formateFirebaseDate)
                .isAfter(DateTime.parse(formateUserDate))) {
              return WtqBadge(
                true,
                id: id,
              );
            }

            return Container();
          } else {
            return WtqBadge(
              false,
              id: id,
            );
          }
        },
      );
    });
  }
}

class WtqBadge extends StatelessWidget {
  final bool isVisible;
  final String id;

  WtqBadge(this.isVisible, {@required this.id});

  @override
  Widget build(BuildContext context) {
    return Badge(
      elevation: 2,
      position: BadgePosition.topRight(top: 15, right: 20),
      badgeColor: kGreen,
      showBadge: isVisible,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(FontAwesomeIcons.solidBell),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageBoard(this.id),
              ),
            );
          },
        ),
      ),
    );
  }
}

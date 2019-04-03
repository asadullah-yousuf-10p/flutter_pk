import 'package:flutter/material.dart';
import 'package:flutter_pk/caches/user.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/helpers/formatters.dart';
import 'package:flutter_pk/schedule/model.dart';
import 'package:flutter_pk/schedule/session_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pk/theme.dart';
import 'package:flutter_pk/util.dart';
import 'package:flutter_pk/widgets/custom_app_bar.dart';

class SchedulePage extends StatefulWidget {
  @override
  SchedulePageState createState() {
    return new SchedulePageState();
  }
}

class SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  final Color kUnConfirmedColor = Colors.grey[100];
  final Color kConfirmedColor = Colors.green[100];
  final Color kRejectedColor = Colors.orange[100];
  final Color kConfirmNotificationTextColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Schedule',
            ),
            _buildBody()
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildRegistrationConfirmationBanner(),
          _buildSessionList(),
        ],
      ),
    );
  }

  Widget _buildRegistrationConfirmationBanner() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(FireStoreKeys.dateCollection)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        DateTime registrationConfirmationDate =
            toDateTime(snapshot.data.documents.first.data['registrationConfirmationDate']);

        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(FireStoreKeys.userCollection)
              .where("id", isEqualTo: userCache.user.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            User user = User.fromSnapshot(snapshot.data.documents.first);

            if (user == null || !user.isRegistered) {
              return Container();
            }

            var registrationDateExpired =
                registrationConfirmationDate.compareTo(DateTime.now()) < 0;
            String message = (user.isRegistrationConfirmed)
                ? "Congratulations! You're shortlisted for this event."
                : registrationDateExpired
                    ? "We're sorry! You're not shortlisted for this event."
                    : "We will inform you about your registration status shortly.";
            Color bgColor = (user.isRegistrationConfirmed)
                ? kConfirmedColor
                : registrationDateExpired ? kRejectedColor : kUnConfirmedColor;

            return Container(
              decoration: BoxDecoration(
                color: bgColor,
              ),
              height: 30.0,
              alignment: Alignment.center,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kConfirmNotificationTextColor,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSessionList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(FireStoreKeys.dateCollection)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.documents?.first == null)
            return Center(
              child: Text(
                'Nothing found!',
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            );

          return StreamBuilder<QuerySnapshot>(
            stream: snapshot.data.documents.first.reference
                .collection(FireStoreKeys.sessionCollection)
                .orderBy('startDateTime')
                .snapshots(),
            builder: (context, snapshot) {
              var items = snapshot.data?.documents;
              if (items == null) return Container();
              if (items.length < 1) return Container();
              return ListView(
                padding: const EdgeInsets.only(top: 20.0),
                children: items
                    .map((data) => _buildSessionItem(context, data))
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSessionItem(BuildContext context, DocumentSnapshot data) {
    final session = Session.fromSnapshot(data);
    var hour = session.startDateTime?.hour;
    var minute = session.startDateTime?.minute;

    if (hour == null || minute == null)
      return Center(
        child: Text(
          'Nothing found!',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
              ),
        ),
      );

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    '${hour < 10 ? '0' + hour.toString() : hour.toString()}:${minute < 10 ? '0' + minute.toString() : minute.toString()}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'HRS',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorDictionary.stringToColor[session?.color],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    session.title,
                    style: TextStyle(
                        color:
                            ColorDictionary.stringToColor[session?.textColor]),
                  ),
                  subtitle: Text(
                    '${formatDate(
                      session?.startDateTime,
                      DateFormats.shortUiDateTimeFormat,
                    )} - ${formatDate(
                      session?.endDateTime,
                      DateFormats.shortUiTimeFormat,
                    )}',
                    style: TextStyle(
                      color: ColorDictionary.stringToColor[session?.textColor],
                    ),
                  ),
                  onTap: () async {
                    if (session.id != GlobalConstants.breakId)
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SessionDetailPage(
                                session: session,
                              ),
                        ),
                      );
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
        ),
      ],
    );
  }
}

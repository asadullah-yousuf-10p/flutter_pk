import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/formatters.dart';
import 'package:flutter_pk/models/schedule/Speakers.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqAppbarTitle.dart';
import 'package:flutter_pk/widgets/WtqDetail.dart';
import 'package:flutter_pk/widgets/WtqTitle.dart';

class EventDetail extends StatelessWidget {
  final String speakerId;
  final String title;
  final String description;
  final Timestamp startDate;
  final Timestamp endDate;

  EventDetail(
      {@required this.speakerId,
      this.title = '',
      this.description = '',
      this.startDate,
      this.endDate});

  @override
  Widget build(BuildContext context) {
    Speakers speaker = Speakers();

    return Scaffold(
      appBar: AppBar(
        title: WtqAppbarTitle(
          title: 'Event Detail',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          description.isEmpty
              ? Container()
              : Container(
                  width: ScreenSize.blockSizeHorizontal * 100,
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: <Widget>[
                      WtqTitle(
                        title: this.title,
                      ),
                      Padding(padding: EdgeInsets.all(16)),
                      WtqDetail(description: this.description),
                      Padding(padding: EdgeInsets.all(16)),
                    ],
                  ),
                ),
          speakerId.isEmpty
              ? Container()
              : StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection(FireStoreKeys.speakerCollection)
                      .document(this.speakerId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      speaker = Speakers.fromJson(
                        jsonDecode(
                          jsonEncode(snapshot.data.data),
                        ),
                      );
                      return Container(
                        width: ScreenSize.blockSizeHorizontal * 100,
                        //height: ScreenSize.blockSizeVertical*100,
                        child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          //padding: EdgeInsets.all(16),
                          children: <Widget>[
                            WtqTitle(
                              title: 'Speaker',
                            ),
                            Padding(padding: EdgeInsets.all(8)),
                            Text(speaker.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(color: kBlueDark, fontSize: 15)),
                            Padding(padding: EdgeInsets.all(16)),
                            WtqDetail(description: speaker.description),
                          ],
                        ),
                      );
                    } else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  })
        ],
      ),
    );
  }
}

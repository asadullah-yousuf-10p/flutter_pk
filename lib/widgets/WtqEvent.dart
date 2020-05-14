import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/models/about/AboutModel.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqTitle.dart';

class WtqEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AboutModel model = AboutModel();

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(
              '${FireStoreKeys.eventCollection}/women_tech_quest/AboutWtq')
          .snapshots(),
      builder: (context, snapshot) {
        // print(snapshot.data.documents[0].data);

        if (snapshot.hasData) {
          model = AboutModel.fromJson(
            jsonDecode(
              jsonEncode(snapshot.data.documents.first.data),
            ),
          );
          return Container(
            width: ScreenSize.blockSizeHorizontal * 100,
            //height: ScreenSize.blockSizeVertical * 100,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                WtqTitle(
                  title: model.detail,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Date",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: kBlue,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 75),
                    ),
                    Text(
                      model.date.replaceAll(RegExp(r'\\n'), '\n'),
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            fontSize: 15,
                            color: kBlueDark,
                            height: 0.8
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Timing",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: kBlue,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                    ),
                    Container(
                      width: ScreenSize.blockSizeHorizontal * 55,
                      child: Text(
                        model.timing.replaceAll(RegExp(r'\\n'), '\n'),
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              fontSize: 15,
                              color: kBlueDark,
                              height: 0.8
                            ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Venues",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: kBlue,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                    ),
                    Container(
                      width: ScreenSize.blockSizeHorizontal * 50,
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: model.address.length,
                          itemBuilder: (context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.venues[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                          fontSize: 15,
                                          color: kBlueDark,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  Container(
                                    width: ScreenSize.blockSizeHorizontal * 50,
                                    child: Text(
                                      model.address[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle
                                          .copyWith(
                                            fontSize: 15,
                                            color: kBlueDark,
                                          ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 30))
                                ]);
                          }),
                    )
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

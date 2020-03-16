import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/models/about/AboutModel.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqDetail.dart';
import 'package:flutter_pk/widgets/WtqTitle.dart';

class AboutWtq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AboutModel model = AboutModel();
    ScreenSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Why Participate",
          style: Theme.of(context)
              .textTheme
              .subtitle
              .copyWith(fontSize: 19, color: Colors.white),
        ),
      ),
      body: Container(
        width: ScreenSize.blockSizeHorizontal * 100,
        //height: ScreenSize.blockSizeVertical * 100,
        child: StreamBuilder<QuerySnapshot>(
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
                  primary: true,
                  shrinkWrap: false,
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        imageUrl: model.imageUrl,
                        imageBuilder: (context, imageProvider) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              model.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Text(error.toString());
                        },
                        placeholder: (context, url) {
                          return Container(
                            width: 10,
                            height: 10,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: model.title.length,
                      itemBuilder: (context, index) {
                        return Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          children: <Widget>[
                            Container(
                              width: ScreenSize.blockSizeHorizontal * 90,
                              child: WtqTitle(
                              title: model.title[index],
                              ),
                            ),
                           
                            Container(
                              width: ScreenSize.blockSizeHorizontal * 90,
                              child: WtqDetail(
                                description: model.description[index],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            )
                          ],
                        );
                      },
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
        ),
      ),
    );
  }
}

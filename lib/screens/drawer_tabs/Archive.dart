import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/LaunchUrl.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/models/archive/Archive.dart';
import 'package:flutter_pk/theme/theme.dart';

class Archive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArchiveModel model;
    LaunchUrl url;
    ScreenSize().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Archive",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(fontSize: 19, color: Colors.white),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection(
                    '${FireStoreKeys.eventCollection}/women_tech_quest/archive')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      model = ArchiveModel.fromJson(
                        jsonDecode(
                          jsonEncode(snapshot.data.documents[index].data),
                        ),
                      );
                      url = LaunchUrl(model.link);
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            url.urlLauncher();
                          },
                          child: ArchivePhoto(
                            title: model.title,
                            imageUrl: model.imageUrl,
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class ArchivePhoto extends StatelessWidget {
  final String title;
  final String link;
  final String imageUrl;

  ArchivePhoto({this.title, this.link, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.blockSizeHorizontal * 100,
      //  height: ScreenSize.blockSizeVertical * 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0xff1e79cbbd),
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0),
        ],
      ),
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenSize.blockSizeHorizontal*100,
            height: ScreenSize.blockSizeVertical*25,
            child: Image.network(this.imageUrl,fit: BoxFit.cover,),
          ),

          Container(
            width: ScreenSize.blockSizeHorizontal * 90,
            height: ScreenSize.blockSizeVertical * 6,
            //color: Colors.grey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      this.title,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: kBlueDark,
                    size: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

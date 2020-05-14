import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqCard.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(18),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection(
                    '${FireStoreKeys.eventCollection}/women_tech_quest/${FireStoreKeys.buyTicket}')
                .orderBy('order')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: ScreenSize.blockSizeHorizontal * 100,
                  height: ScreenSize.blockSizeVertical * 100,
                  child: GridView.builder(
                      itemCount: snapshot.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 12,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            String url = snapshot
                                .data.documents[index].data['link']
                                .toString();
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: WtqCard(
                            type: cardType.networkImage,
                            imageUrl: snapshot.data.documents[index].data['imageUrl'],
                            fit: BoxFit.scaleDown,
                            caption: snapshot.data.documents[index].data['title'],
                            iconScale: 2,
                          ),
                        );
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

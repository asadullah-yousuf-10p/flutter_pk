import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/models/competitions/Competition.dart';
import 'package:flutter_pk/screens/home_tabs/home_sub_page/DesignContest.dart';
import 'package:flutter_pk/widgets/WtqCard.dart';

class ContestCards extends StatelessWidget {
  final String eventId;

  ContestCards(this.eventId);

  //final bloc = CompetitionBloc();

  @override
  Widget build(BuildContext context) {
    Competition competition = Competition();

    List<String> assetImage = [
      'assets/Icons-02.png',
      'assets/Icons-03.png',
      'assets/Icons-01.png'
    ];

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(
              '${FireStoreKeys.eventCollection}/$eventId/${FireStoreKeys.competitionCollection}')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              mainAxisSpacing: 0,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              competition = Competition.fromJson(
                jsonDecode(
                  jsonEncode(snapshot.data.documents[index].data),
                ),
              );
              //print(competition.rulesTitle);
          
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DesignContest(
                        title: snapshot.data.documents[index].data['title'],
                        description:
                            snapshot.data.documents[index].data['description'],
                        imageUrl:
                            snapshot.data.documents[index].data['imageUrl'],
                        ruleDescription: snapshot
                            .data.documents[index].data['rulesDescription'],
                        ruleTitle:
                            snapshot.data.documents[index].data['rulesTitle'],
                      ),
                    ),
                  );
                },
                child: WtqCard(
                  type: cardType.assetImage,
                  assetUrl: assetImage[index],
                  caption: MediaQuery.of(context).size.width > 320 ? competition.heading : competition.shortHeading,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

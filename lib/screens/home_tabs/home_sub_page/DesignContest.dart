import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/widgets/WtqDetail.dart';
import 'package:flutter_pk/widgets/WtqImage.dart';
import 'package:flutter_pk/widgets/WtqTitle.dart';

class DesignContest extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String ruleTitle;
  final String ruleDescription;

  DesignContest(
      {@required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.ruleDescription,
      @required this.ruleTitle});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.title,
          style: Theme.of(context)
              .textTheme
              .subtitle
              .copyWith(fontSize: 19, color: Colors.white),
        ),
      ),
      body: Container(
        width: ScreenSize.blockSizeHorizontal * 100,
        height: ScreenSize.blockSizeVertical * 100,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            WtqImage(imageUrl: this.imageUrl),
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: WtqTitle(
                  title: this.title,
                )),
            Padding(
              padding: EdgeInsets.only(top: 22),
            ),
            Container(
                width: ScreenSize.blockSizeHorizontal * 100,
                //height: ScreenSize.blockSizeVertical * 15,
                child: WtqDetail(description: this.description)),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            WtqTitle(
              title: this.ruleTitle,
            ),
            Padding(
              padding: EdgeInsets.only(top: 22),
            ),
            Container(
                width: ScreenSize.blockSizeHorizontal * 100,
                //height: ScreenSize.blockSizeVertical * 30,
                child: WtqDetail(description: this.ruleDescription)
                ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }
}

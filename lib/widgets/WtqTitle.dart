import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/theme/theme.dart';

class WtqTitle extends StatelessWidget {
  final String title;

  WtqTitle({this.title = '10PEARLS'});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.title,
          softWrap: true,
          style: Theme.of(context).textTheme.headline.copyWith(fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
        ),
        Container(
          height: ScreenSize.blockSizeVertical * 0.2,
          width: ScreenSize.blockSizeHorizontal * 12,
          color: kGreen,
        ),
      ],
    );
  }
}

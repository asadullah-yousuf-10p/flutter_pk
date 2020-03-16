import 'package:flutter/material.dart';

class WtqCaption extends StatelessWidget {
  final String caption;

  WtqCaption({this.caption = 'Women Tech Quest - 2020'});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.caption,
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.visible,
      style: Theme
          .of(context)
          .textTheme
          .caption,
    );
  }
}

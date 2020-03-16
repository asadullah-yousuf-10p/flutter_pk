import 'package:flutter/material.dart';
import 'package:flutter_pk/theme/theme.dart';

class WtqDrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function tap;

  WtqDrawerItem(
      {@required this.title, @required this.iconData, @required this.tap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: this.tap,
      leading: Icon(
        this.iconData,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        this.title,
        style: Theme.of(context)
            .textTheme
            .subtitle
            .copyWith(color: kBlueDark, letterSpacing: -0.11),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WtqAppbarTitle extends StatelessWidget {
  final String title;

  WtqAppbarTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .subtitle
          .copyWith(fontSize: 19, color: Colors.white),
    );
  }
}

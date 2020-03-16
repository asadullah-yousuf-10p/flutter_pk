import 'package:flutter/material.dart';
import 'package:flutter_pk/theme/theme.dart';

class WtqDetail extends StatelessWidget {
  final String description;

  WtqDetail({@required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.description.replaceAll(RegExp(r'\\n'), '\n'),
      softWrap: true,
      style: Theme.of(context)
          .textTheme
          .subtitle
          .copyWith(color: kBlueDark, fontSize: 15),
    );
  }
}

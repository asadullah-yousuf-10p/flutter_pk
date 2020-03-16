import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/theme/theme.dart';

class WtqLine extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return  Container(
      height: ScreenSize.blockSizeVertical * 0.2,
      width: ScreenSize.blockSizeHorizontal * 15,
      color: kGreen,
    );
  }
}

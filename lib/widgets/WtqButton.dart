import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';

class WtqButton extends StatelessWidget {

  final Function buttonClick;
final String text;


  WtqButton({this.buttonClick,this.text="Get Started",});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonClick,
      child: Container(
        width: ScreenSize.blockSizeHorizontal*80,
        height: 40,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 15),
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xff40e10a7d),
                offset: Offset(0, 3),
                blurRadius: 8,
                spreadRadius: 0)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/theme/theme.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String lable;
  final int maxLine;
  final double fieldHeight;
  final TextEditingController controller;
  final Function(String) function;

  CustomTextField(
      {@required this.hintText,
      @required this.lable,
      @required this.maxLine,
      @required this.fieldHeight,
      @required this.controller,
      @required this.function});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: ScreenSize.blockSizeHorizontal * 85,
        // height: widget.fieldHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: kGreen.withOpacity(0.3),
                offset: Offset(2, 2),
                blurRadius: 2,
                spreadRadius: 0.5),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          validator: widget.function,
          controller: widget.controller,
          maxLines: widget.maxLine,
          style:
              Theme.of(context).textTheme.subtitle.copyWith(color: kBlueDark),
          decoration: InputDecoration(
            helperStyle: TextStyle(
              color: Color(0xffff79cbbd),
            ),
//            prefixStyle:
//                Theme.of(context).textTheme.subtitle.copyWith(color: kGreen),
//            prefix: Wrap(
//              direction: Axis.horizontal,
//              spacing: 15,
//              children: <Widget>[Text(widget.lable), Text('|'), Text('')],
//            ),
            labelText: widget.lable,
//            labelStyle:
//                Theme.of(context).textTheme.subtitle.copyWith(color: kGreen),

//            errorBorder:
//                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 0, color: Theme.of(context).scaffoldBackgroundColor),
            ),
//            hintStyle: Theme.of(context)
//                .textTheme
//                .subtitle
//                .copyWith(color: Colors.grey),
//            hintText: widget.hintText,
            //labelText: widget.lable,
          ),
        ),
      ),
    );
  }
}

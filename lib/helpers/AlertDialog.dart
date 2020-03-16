import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  void alert(AlertType type, String title, String desc, String buttonText,
      Color buttonColor, BuildContext context,Function() onClicked) {
    final _alert = Alert(
      context: context,
      type: type,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.white,
                ),
          ),
          color: buttonColor,
          onPressed: onClicked,
        )
      ],
    );
    _alert.show();
  }
}

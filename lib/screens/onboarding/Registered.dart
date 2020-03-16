import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/AlertDialog.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/profile/model.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqButton.dart';
import 'package:flutter_pk/widgets/WtqLine.dart';

class Registered extends StatelessWidget {
  final User user = userCache.user;
  final CustomAlertDialog dialog = CustomAlertDialog();
  final String number;

  Registered({@required this.number});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: ScreenSize.blockSizeHorizontal * 100,
            height: ScreenSize.blockSizeVertical * 100,
            child: Wrap(
                spacing: 00,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Center(
                    child: Wrap(
                      textDirection: TextDirection.rtl,
                      direction: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Container(
                            width: ScreenSize.blockSizeHorizontal * 52,
                            height: ScreenSize.blockSizeVertical * 19,
                            child: Image.asset(
                              "assets/icon/4.0x/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 1),
                            child: WtqLine()),
                        Padding(
                          padding: const EdgeInsets.only(right: 40, top: 30),
                          child: Text(
                            "!CONGRATS",
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40, top: 30),
                          child: Text(
                            """YOU HAVE SUCCESSFULLY""",
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context)
                                .textTheme
                                .subhead
                                .copyWith(color: kGreen),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                            """SIGNED UP""",
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: kGreen,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40, top: 30),
                          child: Container(
                            width: ScreenSize.blockSizeHorizontal * 57,
                            // height: ScreenSize.blockSizeVertical * 16,
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(fontSize: 22),
                                children: [
                                  TextSpan(text: "Gear up for an\n"),
                                  TextSpan(
                                    text: "intense & inspiring\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                            fontSize: 22,
                                            color:
                                                Theme.of(context).accentColor),
                                  ),
                                  TextSpan(
                                      text: "competition")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 90,bottom: 10),
                    child: Center(
                      child: WtqButton(
                        text: "Show me WTQ 2020 details",
                        buttonClick: () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.home, (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

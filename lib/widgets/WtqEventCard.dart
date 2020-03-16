import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/formatters.dart';
import 'package:flutter_pk/theme/theme.dart';

class WtqEventCard extends StatelessWidget {
  final String title;
  final Color color;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final bool canOpenDetail;

  WtqEventCard({this.title, this.color, this.startDateTime, this.endDateTime, this.canOpenDetail});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 7),
      child: Container(
        width: ScreenSize.blockSizeHorizontal * 100,
        //height: ScreenSize.blockSizeVertical * 8.5,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xff1e79cbbd),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenSize.blockSizeVertical * 12,
                  width: ScreenSize.blockSizeHorizontal * 1,
                  decoration: BoxDecoration(
                    color: this.color,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.center,
                      direction: Axis.vertical,
                      spacing: 6,

                      children: <Widget>[
                        Container(
                          width:ScreenSize.blockSizeHorizontal*50,
                          child: Text(
                            this.title,
                            softWrap: true,
                            style: Theme.of(context).textTheme.subtitle.copyWith(
                                color: kBlueDark, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          '${formatDate(
                            this.startDateTime,
                            DateFormats.shortUiTimeFormat,
                          )} - ${formatDate(
                            this.endDateTime,
                            DateFormats.shortUiTimeFormat,
                          )}',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                              color: kBlueDark,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.15),
                        ),
                      ],
                    )
//
                    ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                CupertinoIcons.right_chevron,
                color: (this.canOpenDetail) ? kBlueDark : Colors.grey[50],
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_pk/global.dart';

class AboutEvent extends StatelessWidget {
  const AboutEvent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'About Women Tech Quest',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            GlobalConstants.aboutWtqDetails,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Coding Competition',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            GlobalConstants.codingCompetitionDetails,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Testing Competition',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            GlobalConstants.testingCompetitionDetails,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Design Competition',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            GlobalConstants.designCompetitionDetails,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'What\'s in it for you?',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            GlobalConstants.prizeDetails,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Guidelines',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            GlobalConstants.guidelinesDetails,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
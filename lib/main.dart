import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pk/screens/home/event_detail_container.dart';
import 'package:flutter_pk/screens/onboarding/onboarding.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/provider/Preference.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:provider/provider.dart';

///
///  Root of the application
///  when the app is first launch [CommunityApp] is rendered
///  in Community app initial route [main] is [OnboardingPage]
///  and home route is [EventDetailContainerState]
///
/// In this application both [Provider] and [Bloc] are use for state management
///
///  [Provider] is  use to pass the shared preference through out the app
///  only string value of dateTime is save in shared preference for app bar bell badge
///  [Preference] class.
///
/// For all the business logic related stuff we have use [bloc] pattern.
///

void main() {
  runApp(CommunityApp());
}

class CommunityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    return ChangeNotifierProvider<Preference>(
      create: (context) => Preference(key: 'lastDate'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Women Tech Quest',
        theme: theme,
        initialRoute: Routes.main,
        routes: {
          Routes.home: (context) => EventDetailContainerStream(),
          Routes.main: (context) => OnboardingPage(title: 'Woman Tech Quest')
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pk/helpers/AlertDialog.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/profile/login.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/shared_preferences.dart';
import 'package:flutter_pk/screens/onboarding/registration.dart';
import 'package:flutter_pk/widgets/WtqButton.dart';
import 'package:flutter_pk/widgets/WtqLine.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _showSwipeText = false;
  bool _isFetchingSharedPreferences = false;
  SharedPreferencesHandler preferences;
  CustomAlertDialog dialog;
  List<Widget> tabPages;

  LoginService service = LoginService();

  @override
  void initState() {
    super.initState();
    dialog = CustomAlertDialog();
    service.initialize();
    preferences = SharedPreferencesHandler();
    _getSharedPreferences();
  }

  void _getSharedPreferences() async {
    setState(() => _isFetchingSharedPreferences = true);
    try {
      var userId =
          await preferences.getValue(SharedPreferencesKeys.firebaseUserId);
      if (userId != null) {
        await userCache.getUser(userId);
        await Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home,
          (Route<dynamic> route) => false,
        );
      }
    } catch (ex) {
      print(ex);
      dialog.alert(AlertType.error, "Oops!", "An error has occurred", "DISMISS",
          Colors.red, context, () {
        Navigator.of(context).pop();
      });
    } finally {
      setState(() {
        _isFetchingSharedPreferences = false;
        _showSwipeText = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    return Stack(
      children: <Widget>[
        Scaffold(
          body: _buildBody(context),
        ),
        _isLoading ? FullScreenLoader() : Container()
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        width: ScreenSize.blockSizeHorizontal * 100,
        height: ScreenSize.blockSizeVertical * 100,
        child: Center(child: _buildFirstSwiperControlPage(context)),
      ),
    );
  }

  Widget _buildFirstSwiperControlPage(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Wrap(
              spacing: 80,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: <Widget>[
                Center(
                  child: Wrap(
                    textDirection: TextDirection.rtl,
                    direction: Axis.vertical,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 40),
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
                              left: 40, right: 40, top: 5),
                          child: WtqLine()),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, top: 40),
                        child: Container(
                          width: ScreenSize.blockSizeHorizontal * 70,
                          height: ScreenSize.blockSizeVertical * 20,
                          child: Wrap(
                            direction: Axis.vertical,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text(
                                "Get information about the event",
                                textDirection: TextDirection.rtl,
                                style: Theme.of(context).textTheme.display1,
                              ),
                              Text(
                                "and keep yourself updated",
                                textDirection: TextDirection.rtl,
                                style: Theme.of(context).textTheme.display1,
                              ),
                              Text(
                                "!with the exciting happenings",
                                textDirection: TextDirection.rtl,
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 120),
                  child: Center(
                    child: _showSwipeText
                        ? WtqButton(
                            text: "Get Started",
                            buttonClick: () {
                              _handleSignIn();
                            },
                          )
                        : CircularProgressIndicator(),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Future _handleSignIn() async {
    userCache.clear();
    await preferences.clearPreferences();

    setState(() => _isLoading = true);

    try {
      String userId = await service.initiateLogin();
      await userCache.getUser(userId);

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegistrationPage(number: userCache.user.mobileNumber),
        ),
      );
    } catch (ex) {
      print(ex);
      dialog.alert(AlertType.error, "Oops!", "An error has occurred", "DISMISS",
          Colors.red, context, () {
        Navigator.of(context).pop();
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

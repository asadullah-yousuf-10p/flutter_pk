import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/AlertDialog.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/regex-helpers.dart';
import 'package:flutter_pk/helpers/shared_preferences.dart';
import 'package:flutter_pk/profile/model.dart';
import 'package:flutter_pk/screens/onboarding/Registered.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqButton.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';

class RegistrationPage extends StatefulWidget {
  final String number;

  RegistrationPage({@required this.number});

  @override
  RegistrationPageState createState() {
    return new RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  PageController controller = PageController();
  final GlobalKey<FormState> _contactFormKey = new GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController studentProfessionalController = TextEditingController();
  int pageViewItemCount = 3;

  bool _isLoading = false;
  User user = userCache.user;
  CustomAlertDialog dialog;

  @override
  void initState() {
    super.initState();
    dialog = CustomAlertDialog();
    nameController.text = user.name;
    mobileNumberController.text =
        user.mobileNumber == null ? '+92' : widget.number;
    designationController.text = "Student";
    studentProfessionalController.text = "Student";
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            child: _buildContactSetupView(context),
          ),
        ),
        _isLoading ? FullScreenLoader() : Container()
      ],
    );
  }

  Widget _buildContactSetupView(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _contactFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "REGISTRATION",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Container(
                  height: ScreenSize.blockSizeVertical * 0.3,
                  width: ScreenSize.blockSizeHorizontal * 15,
                  color: kGreen,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  width: ScreenSize.blockSizeHorizontal * 100,
                  //height: ScreenSize.blockSizeVertical * 10,
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: <Widget>[
                        Text(
                          "Please enter accurate information",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontSize: 15, letterSpacing: -0.15),
                        ),
                        Text(
                          "and provide a valid phone number",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontSize: 15, letterSpacing: -0.15),
                        ),
                        Text(
                          "so we may contact you.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontSize: 15, letterSpacing: -0.15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 25),
                child: Container(
                  width: ScreenSize.blockSizeHorizontal * 80,
                  //height: 50,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff2e79cbbd),
                          offset: Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: kBlueDark),
                    controller: nameController,
                    validator: _validateName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      helperStyle: TextStyle(
                        color: Color(0xffff79cbbd),
                      ),
                      hintText: 'Name',
                      prefix: Wrap(
                        direction: Axis.horizontal,
                        spacing: 15,
                        children: <Widget>[
                          Text('Name     '),
                          Text('|'),
                          Text('')
                        ],
                      ),
                      prefixStyle: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: kGreen),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  width: ScreenSize.blockSizeHorizontal * 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff2e79cbbd),
                          offset: Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(13)],
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: kBlueDark),
                    focusNode: focusNode,
                    controller: mobileNumberController,
                    validator: _validatePhoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      helperStyle: TextStyle(
                        color: kGreen,
                      ),
                      hintText: 'Enter mobile number',
                      prefix: Wrap(
                        direction: Axis.horizontal,
                        spacing: 15,
                        children: <Widget>[
                          Text('Mobile #'),
                          Text('|'),
                          Text('')
                        ],
                      ),
                      prefixStyle: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: kGreen),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 145, bottom: 5),
                child: WtqButton(
                  text: "Proceed",
                  buttonClick: () async {
                    if (nameController.text.isEmpty ||
                        mobileNumberController.text.isEmpty) {
                      dialog.alert(
                          AlertType.error,
                          "Error",
                          "Please Enter your name or number",
                          "ok",
                          Colors.redAccent,
                          context, () {
                        Navigator.of(context).pop();
                      });
                    } else {
                      await _submitDataToFirestore();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validateName(String name) {
    return name.length == 0 ? 'Name is required' : null;
  }

  String _validatePhoneNumber(String number) {
    if (number.isEmpty) return 'Phone number required';
    if (number.length < GlobalConstants.phoneNumberMaxLength ||
        !RegexHelpers.phoneNumberRegex.hasMatch(number))
      return 'You wouldn\'t want to miss any important update! \nPlease enter a valid mobile number';

    return null;
  }

  Future _submitDataToFirestore() async {
    setState(() => _isLoading = true);
    try {
      Firestore.instance.runTransaction(
        (transaction) async {
          await transaction.update(
            user.reference,
            {
              'registration': Occupation(
                type: 'Student',
                workOrInstitute: '10Pearls',
                designation: 'Student',
              ).toJson(),
              'mobileNumber': mobileNumberController.text,
              'isRegistered': true
            },
          );
        },
      );

      await userCache.getUser(user.id, useCached: false);
      await SharedPreferencesHandler()
          .setPreference(SharedPreferencesKeys.firebaseUserId, user.id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Registered(
            number: mobileNumberController.text,
          ),
        ),
      );
    } catch (ex) {
      print(ex);
      dialog.alert(AlertType.error, "Oops!", "An error has occurred", "DISMISS",
          Colors.white, context, () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

class Occupation {
  final String type;
  final String workOrInstitute;
  final String designation;
  final DocumentReference reference;

  Occupation({
    this.type,
    this.designation = 'not applicable',
    this.workOrInstitute,
    this.reference,
  });

  Occupation.fromMap(Map map, {this.reference})
      : type = map['occupation'],
        designation = map['designation'],
        workOrInstitute = map['workOrInstitute'];

  Map<String, dynamic> toJson() => {
        "occupation": this.type,
        "workOrInstitute": this.workOrInstitute,
        "designation": this.designation,
      };

  Occupation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

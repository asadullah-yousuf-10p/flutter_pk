import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/helpers/regex-helpers.dart';
import 'package:flutter_pk/widgets/dots_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() {
    return new RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  PageController controller = PageController();

  final GlobalKey<FormState> _mobileNumberFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _reasonToAttendFormKey =
      new GlobalKey<FormState>();
  final GlobalKey<FormState> _registrationFormKey = new GlobalKey<FormState>();

  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _reasonToAttendController = TextEditingController();

  FocusNode focusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();

  int pageViewItemCount = 3;

  bool _isStudent = false;
  bool _isLoading = false;

  int _competitionRadioValue = 0;
  int _occupationRadioValue = 0;

  var competitionNames = ['Coding', 'Design', 'Testing'];
  var occupationNames = ['Professional', 'Student'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileNumberController.text = userCache.user.mobileNumber == null
        ? '+92'
        : userCache.user.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'Registration',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 24.0),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: <Widget>[
                      userCache.user.mobileNumber == null
                          ? _buildNumberSetupView(
                              context,
                              GlobalConstants.wtqImportantNotes,
                            )
                          : _buildNumberSetupView(
                              context,
                              GlobalConstants.editNumberDisplayText,
                            ),
                      _buildStudentProfessionalView(),
                      _buildDesignationEntryView()
                    ],
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                DotsIndicator(
                  controller: controller,
                  itemCount: pageViewItemCount,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        _isLoading ? FullScreenLoader() : Container()
      ],
    );
  }

  Widget _buildNumberSetupView(BuildContext context, String displayText) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 128.0, right: 128.0),
              child: Center(
                child: Image(
                  image: AssetImage('assets/wtq_splash.png'),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                displayText,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Form(
              key: _mobileNumberFormKey,
              child: Text(''),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('NEXT'),
                        Icon(
                          Icons.arrow_forward,
                          size: 24.0,
                        )
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_mobileNumberFormKey.currentState.validate()) {
                        focusNode.unfocus();
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Center _buildStudentProfessionalView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 60.0,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  Icons.important_devices,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                Icon(
                  Icons.content_paste,
                  size: 60.0,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Form(
                key: _registrationFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      focusNode: _mobileFocusNode,
                      controller: _mobileNumberController,
                      maxLength: GlobalConstants.phoneNumberMaxLength,
                      textInputAction: TextInputAction.done,
                      validator: (value) => _validatePhoneNumber(value),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'Enter mobile number',
                          labelText: 'Mobile number'),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          size: 24.0,
                        ),
                        Text('BACK'),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      controller.animateToPage(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('NEXT'),
                        Icon(
                          Icons.arrow_forward,
                          size: 24.0,
                        ),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      focusNode.unfocus();
                      if (_registrationFormKey.currentState.validate()) {
                        if (_isStudent) {
                          await _submitDataToFirestore();
                          Alert(
                            context: context,
                            type: AlertType.info,
                            style: new AlertStyle(
                                isCloseButton: false,
                                isOverlayTapDismiss: false),
                            title: "Success!",
                            desc:
                                "Your are registered successfully!\nYou will receive a confirmation message soon!",
                            buttons: [
                              DialogButton(
                                child: Text("COOL!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          color: Colors.white,
                                        )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ).show();
                        } else {
                          controller.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Center _buildDesignationEntryView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 128.0, right: 128.0),
              child: Center(
                child: Image(
                  image: AssetImage('assets/wtq_splash.png'),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: new Text(
                'In which competition you want to take part in?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RadioListTile(
                  value: 0,
                  groupValue: _competitionRadioValue,
                  onChanged: (int) => competition(int),
                  title: new Text(
                    competitionNames[0],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 1,
                  groupValue: _competitionRadioValue,
                  onChanged: (int) => competition(int),
                  title: new Text(
                    competitionNames[1],
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                new RadioListTile(
                  value: 2,
                  groupValue: _competitionRadioValue,
                  onChanged: (int) => competition(int),
                  title: new Text(
                    competitionNames[2],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: new Text(
                'What is your occupation?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RadioListTile(
                  value: 0,
                  groupValue: _occupationRadioValue,
                  onChanged: (int) => occupation(int),
                  title: new Text(
                    occupationNames[0],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 1,
                  groupValue: _occupationRadioValue,
                  onChanged: (int) => occupation(int),
                  title: new Text(
                    occupationNames[1],
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                'What objectives do you plan on achieving through participating in WomenTechQuest?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Form(
              key: _reasonToAttendFormKey,
              child: ListTile(
                title: TextFormField(
                  focusNode: focusNode,
                  controller: _reasonToAttendController,
                  maxLength: GlobalConstants.entryMaxLength,
                  validator: (value) => _validateReasonToAttend(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Your answer',
                    labelText: 'Your answer',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          size: 24.0,
                        ),
                        Text('BACK'),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      controller.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('DONE'),
                        Icon(
                          Icons.check_circle,
                          size: 24.0,
                        ),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      focusNode.unfocus();
                      if (_reasonToAttendFormKey.currentState.validate()) {
                        await _submitDataToFirestore();
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Success!",
                          style: new AlertStyle(
                              isCloseButton: false, isOverlayTapDismiss: false),
                          desc:
                              "Your are registered successfully!\nYou will receive a confirmation message soon!",
                          buttons: [
                            DialogButton(
                              child: Text("COOL!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        color: Colors.white,
                                      )),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ).show();
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String _validatePhoneNumber(String number) {
    if (number.isEmpty) return 'Phone number required';
    if (number.length < GlobalConstants.phoneNumberMaxLength ||
        !RegexHelpers.phoneNumberRegex.hasMatch(number))
      return 'Please enter a valid mobile number';
  }

  String _validateReasonToAttend(String reason) {
    if (reason.isEmpty) return 'Please write an answer';
  }

  Future _submitDataToFirestore() async {
    setState(() => _isLoading = true);
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(userCache.user.reference, {
          'registration': Registration(
                  occupation: occupationNames[_occupationRadioValue],
                  competition: competitionNames[_competitionRadioValue],
                  reasonToAttend: _reasonToAttendController.text)
              .toJson(),
          'mobileNumber': _mobileNumberController.text,
          'isRegistered': true
        });
      });

      await userCache.getCurrentUser(userCache.user.id, useCached: false);
    } catch (ex) {
      print(ex);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Oops!",
        desc: "An error has occurred",
        buttons: [
          DialogButton(
            child: Text("Dismiss",
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    )),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          )
        ],
      ).show();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  competition(int) {
    setState(() {
      _competitionRadioValue = int;
    });
  }

  occupation(int) {
    setState(() {
      _occupationRadioValue = int;
    });
  }
}

class Registration {
  final String competition;
  final String occupation;
  final String reasonToAttend;
  final DocumentReference reference;

  Registration(
      {this.competition, this.occupation, this.reasonToAttend, this.reference});

  Registration.fromMap(Map<String, dynamic> map, {this.reference})
      : occupation = map['occupation'],
        competition = map['competition'],
        reasonToAttend = map['reasonToAttend'];

  Map<String, dynamic> toJson() => {
        "occupation": this.occupation,
        "competition": this.competition,
        "reasonToAttend": this.reasonToAttend,
      };

  Registration.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

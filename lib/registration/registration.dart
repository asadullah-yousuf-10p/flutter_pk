import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/helpers/regex-helpers.dart';
import 'package:flutter_pk/widgets/about.dart';
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

  final GlobalKey<FormState> _reasonToAttendFormKey =
      new GlobalKey<FormState>();
  final GlobalKey<FormState> _registrationFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _uniNameFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _techStackFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _orgNameFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _designationFormKey = new GlobalKey<FormState>();

  ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _reasonToAttendController = TextEditingController();
  TextEditingController _uniNameController = TextEditingController();
  TextEditingController _techStackController = TextEditingController();
  TextEditingController _orgNameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();

  FocusNode _reasonToAttendFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _uniNameFocusNode = FocusNode();
  FocusNode _techStackFocusNode = FocusNode();
  FocusNode _orgNameFocusNode = FocusNode();
  FocusNode _designationFocusNode = FocusNode();

  int pageViewItemCount = 4;

  bool _isStudent = false;
  bool _isLoading = false;

  int _competitionRadioValue = 0;
  int _occupationRadioValue = 0;
  int _studentProgramNamesRadioValue = 0;
  int _studentProgramYearsRadioValue = 0;
  int _professionalYearsOfExpRadioValue = 0;
  int _laptopOtionsRadioValue = 0;

  var competitionNames = ['Coding', 'Design', 'Testing'];
  var occupationNames = ['Professional', 'Student'];
  var laptopOptions = ['No', 'Yes'];

  var studentProgramNames = ['Bachelors', 'Masters'];
  var studentProgramYears = ['1st Year', '2nd Year', '3rd Year', '4th Year'];

  var professionalYearsOfExp = [
    'Less than 2 Years',
    '2 - 4 Years',
    '4 - 6 Years',
    'More than 6 Years'
  ];

  @override
  void initState() {
    super.initState();
    _mobileNumberController.text = '+92';
  }

  @override
  Widget build(BuildContext context) {
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
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(width: 48),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: <Widget>[
                      _buildAboutPage(),
                      _buildPhoneInput(),
                      _buildInfoForm(),
                      _buildProfessionalDetailForm(),
                      _buildStudentDetailsForm()
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

  Widget _buildAboutPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AboutEvent(),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.arrow_forward,
                  size: 24.0,
                ),
                label: Text('NEXT'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () => controller.animateToPage(1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn),
              ),
            ),
          ],
        ), //_buildKachra(context, displayText),
      ),
    );
  }

  Center _buildPhoneInput() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: IconTheme(
                data: IconThemeData(color: Colors.blueGrey),
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
                      onPressed: () {
                        if (_registrationFormKey.currentState.validate()) {
                          controller.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Center _buildInfoForm() {
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
                top: 26.0,
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
            Padding(
              padding: const EdgeInsets.only(
                top: 26.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: new Text(
                'Will you bring your own laptop?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RadioListTile(
                  value: 0,
                  groupValue: _laptopOtionsRadioValue,
                  onChanged: (int) => laptop(int),
                  title: new Text(
                    laptopOptions[0],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 1,
                  groupValue: _laptopOtionsRadioValue,
                  onChanged: (int) => laptop(int),
                  title: new Text(
                    laptopOptions[1],
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
                  focusNode: _reasonToAttendFocusNode,
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
                        Text('NEXT'),
                        Icon(
                          Icons.arrow_forward,
                          size: 24.0,
                        ),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_reasonToAttendFormKey.currentState.validate()) {
                        controller.animateToPage(
                            _occupationRadioValue == 0 ? 3 : 4,
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

  Center _buildProfessionalDetailForm() {
    return Center(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Center(
                child: Icon(
                  Icons.laptop_mac,
                  size: 100.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
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
              child: new Text(
                'What is your total years of experience?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RadioListTile(
                  value: 0,
                  groupValue: _professionalYearsOfExpRadioValue,
                  onChanged: (int) => professionalExpYear(int),
                  title: new Text(
                    professionalYearsOfExp[0],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 1,
                  groupValue: _professionalYearsOfExpRadioValue,
                  onChanged: (int) => professionalExpYear(int),
                  title: new Text(
                    professionalYearsOfExp[1],
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                new RadioListTile(
                  value: 2,
                  groupValue: _professionalYearsOfExpRadioValue,
                  onChanged: (int) => professionalExpYear(int),
                  title: new Text(
                    professionalYearsOfExp[2],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 3,
                  groupValue: _professionalYearsOfExpRadioValue,
                  onChanged: (int) => professionalExpYear(int),
                  title: new Text(
                    professionalYearsOfExp[3],
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            _competitionRadioValue == 0 ? getTechStackView() : Container(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 26.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                'Please provide the name of the organization you work at?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Form(
              key: _orgNameFormKey,
              child: ListTile(
                title: TextFormField(
                  focusNode: _orgNameFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term) {
                    _orgNameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_designationFocusNode);
                  },
                  controller: _orgNameController,
                  maxLength: GlobalConstants.entryMaxLength,
                  validator: (value) => _validateField(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Your answer',
                    labelText: 'Organization name',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 26.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                'What is your designation?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Form(
              key: _designationFormKey,
              child: ListTile(
                title: TextFormField(
                  focusNode: _designationFocusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (term) {
                    _designationFocusNode.unfocus();
                  },
                  controller: _designationController,
                  maxLength: GlobalConstants.entryMaxLength,
                  validator: (value) => _validateField(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Your answer',
                    labelText: 'Designation',
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
                      controller.animateToPage(2,
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
                      _techStackFocusNode.unfocus();
                      _orgNameFocusNode.unfocus();
                      _designationFocusNode.unfocus();
                      if (_competitionRadioValue == 0
                          ? _techStackFormKey.currentState.validate() &&
                              _orgNameFormKey.currentState.validate() &&
                              _designationFormKey.currentState.validate()
                          : _orgNameFormKey.currentState.validate() &&
                              _designationFormKey.currentState.validate()) {
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

  Center _buildStudentDetailsForm() {
    return Center(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Center(
                child: Icon(
                  Icons.school,
                  size: 100.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
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
                'Please provide your University/Institute name?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Form(
              key: _uniNameFormKey,
              child: ListTile(
                title: TextFormField(
                  focusNode: _uniNameFocusNode,
                  controller: _uniNameController,
                  maxLength: GlobalConstants.entryMaxLength,
                  validator: (value) => _validateUniversityName(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'University name',
                    labelText: 'University name',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                'In which program you are enrolled in?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RadioListTile(
                  value: 0,
                  groupValue: _studentProgramNamesRadioValue,
                  onChanged: (int) => studentProgram(int),
                  title: new Text(
                    studentProgramNames[0],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 1,
                  groupValue: _studentProgramNamesRadioValue,
                  onChanged: (int) => studentProgram(int),
                  title: new Text(
                    studentProgramNames[1],
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
              child: new Text(
                'What is your current year?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RadioListTile(
                  value: 0,
                  groupValue: _studentProgramYearsRadioValue,
                  onChanged: (int) => studentProgramYear(int),
                  title: new Text(
                    studentProgramYears[0],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 1,
                  groupValue: _studentProgramYearsRadioValue,
                  onChanged: (int) => studentProgramYear(int),
                  title: new Text(
                    studentProgramYears[1],
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                new RadioListTile(
                  value: 2,
                  groupValue: _studentProgramYearsRadioValue,
                  onChanged: (int) => studentProgramYear(int),
                  title: new Text(
                    studentProgramYears[2],
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ),
                new RadioListTile(
                  value: 3,
                  groupValue: _studentProgramYearsRadioValue,
                  onChanged: (int) => studentProgramYear(int),
                  title: new Text(
                    studentProgramYears[3],
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            _competitionRadioValue == 0 ? getTechStackView() : Container(),
            Divider(),
            SizedBox(
              height: 20,
            ),
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
                      controller.animateToPage(2,
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
                      _uniNameFocusNode.unfocus();
                      if (_competitionRadioValue == 0
                          ? _techStackFormKey.currentState.validate() &&
                              _uniNameFormKey.currentState.validate()
                          : _uniNameFormKey.currentState.validate()) {
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
                      } else if (!_uniNameFormKey.currentState.validate()) {
                        _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
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

  String _validateUniversityName(String name) {
    if (name.isEmpty) return 'Please write University/Institute name';
  }

  String _validateField(String value) {
    if (value.isEmpty) return 'This field is required';
  }

  Future _submitDataToFirestore() async {
    setState(() => _isLoading = true);
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(userCache.user.reference, {
          'registration': Registration(
                  occupation: occupationNames[_occupationRadioValue],
                  competition: competitionNames[_competitionRadioValue],
                  laptop: laptopOptions[_laptopOtionsRadioValue],
                  reasonToAttend: _reasonToAttendController.text)
              .toJson(),
          'mobileNumber': _mobileNumberController.text,
          'isRegistered': true,
          'studentDetails': _occupationRadioValue == 1
              ? StudentDetails(
                      currentYear:
                          studentProgramYears[_studentProgramYearsRadioValue],
                      program:
                          studentProgramNames[_studentProgramNamesRadioValue],
                      uniName: _uniNameController.text,
                      techStack: _competitionRadioValue == 0
                          ? _techStackController.text
                          : '')
                  .toJson()
              : null,
          'professionalDetails': _occupationRadioValue == 0
              ? ProfessionalDetails(
                      yearsOfExp: professionalYearsOfExp[
                          _professionalYearsOfExpRadioValue],
                      designation: _designationController.text,
                      organizationName: _orgNameController.text,
                      techStack: _competitionRadioValue == 0
                          ? _techStackController.text
                          : '')
                  .toJson()
              : null,
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

  laptop(int) {
    setState(() {
      _laptopOtionsRadioValue = int;
    });
  }

  studentProgram(int) {
    setState(() {
      _studentProgramNamesRadioValue = int;
    });
  }

  studentProgramYear(int) {
    setState(() {
      _studentProgramYearsRadioValue = int;
    });
  }

  professionalExpYear(int) {
    setState(() {
      _professionalYearsOfExpRadioValue = int;
    });
  }

  getTechStackView() {
    return Column(
      children: <Widget>[
        Divider(),
        Padding(
          padding: const EdgeInsets.only(
            top: 26.0,
            bottom: 16.0,
            left: 32.0,
            right: 32.0,
          ),
          child: Text(
            'On what technology stacks you have worked on?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Form(
          key: _techStackFormKey,
          child: ListTile(
            title: TextFormField(
              focusNode: _techStackFocusNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term) {
                _techStackFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_orgNameFocusNode);
              },
              controller: _techStackController,
              maxLength: GlobalConstants.techStachMaxLength,
              validator: (value) => _validateField(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Java, Objective-C, JavaScript, .Net etc.',
                labelText: 'Technology Stack',
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Registration {
  final String competition;
  final String occupation;
  final String reasonToAttend;
  final String laptop;
  final DocumentReference reference;

  Registration(
      {this.competition,
      this.occupation,
      this.reasonToAttend,
      this.laptop,
      this.reference});

  Registration.fromMap(Map<String, dynamic> map, {this.reference})
      : occupation = map['occupation'],
        competition = map['competition'],
        reasonToAttend = map['reasonToAttend'],
        laptop = map['laptop'];

  Map<String, dynamic> toJson() => {
        "occupation": this.occupation,
        "competition": this.competition,
        "reasonToAttend": this.reasonToAttend,
        "laptop": this.laptop,
      };

  Registration.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class StudentDetails {
  final String uniName;
  final String program;
  final String currentYear;
  final String techStack;
  final DocumentReference reference;

  StudentDetails(
      {this.uniName,
      this.program,
      this.currentYear,
      this.techStack,
      this.reference});

  StudentDetails.fromMap(Map<String, dynamic> map, {this.reference})
      : program = map['program'],
        uniName = map['uniName'],
        currentYear = map['currentYear'],
        techStack = map['techStack'];

  Map<String, dynamic> toJson() => {
        "program": this.program,
        "uniName": this.uniName,
        "currentYear": this.currentYear,
        "techStack": this.techStack,
      };

  StudentDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class ProfessionalDetails {
  final String yearsOfExp;
  final String organizationName;
  final String designation;
  final String techStack;
  final DocumentReference reference;

  ProfessionalDetails(
      {this.yearsOfExp,
      this.organizationName,
      this.designation,
      this.techStack,
      this.reference});

  ProfessionalDetails.fromMap(Map<String, dynamic> map, {this.reference})
      : organizationName = map['organizationName'],
        yearsOfExp = map['yearsOfExp'],
        designation = map['designation'],
        techStack = map['techStack'];

  Map<String, dynamic> toJson() => {
        "organizationName": this.organizationName,
        "yearsOfExp": this.yearsOfExp,
        "designation": this.designation,
        "techStack": this.techStack,
      };

  ProfessionalDetails.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

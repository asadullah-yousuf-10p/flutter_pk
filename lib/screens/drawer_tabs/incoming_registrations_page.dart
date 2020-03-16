import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pk/bloc/image_upload_bloc/bloc.dart';
import 'package:flutter_pk/bloc/event_bloc/model.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/shared_preferences.dart';
import 'package:flutter_pk/repository/ImageRepo.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

class IncomingRegistrationsPage extends StatefulWidget {
  final EventDetails event;

  IncomingRegistrationsPage(this.event);

  @override
  _IncomingRegistrationsPageState createState() =>
      _IncomingRegistrationsPageState();
}

class _IncomingRegistrationsPageState extends State<IncomingRegistrationsPage> {
  ImageRepo _imageRepo;

  @override
  void initState() {
    super.initState();
    _imageRepo = ImageRepo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Send Messages"),
        ),
        body: BlocProvider(
          create: (context) => ImageUploadBloc(imageRepo: _imageRepo),
          child: MessageSend(),
        ));
  }
}

class MessageSend extends StatefulWidget {


  @override
  _MessageSendState createState() => _MessageSendState();
}

class _MessageSendState extends State<MessageSend> {
  final _formKey = GlobalKey<FormState>();

  //RegistrationBloc _registrationBloc;
  //Repository _repository;
  ImageRepo _imageRepo;
  ImageUploadBloc _uploadBloc;
  SharedPreferencesHandler preferences;
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerBody = TextEditingController();
  File _image;
  var random = math.Random();
  int num;
  String imageUrl;
  StorageReference reference;

  @override
  void initState() {
    _imageRepo = ImageRepo();
    _uploadBloc = ImageUploadBloc(imageRepo: _imageRepo);
//    _repository = Repository();
    //_registrationBloc = RegistrationBloc(repository: _repository);
    preferences = SharedPreferencesHandler();
    num = random.nextInt(100);
    super.initState();
  }

  @override
  void dispose() {
    controllerTitle.dispose();
    controllerBody.dispose();
    //_registrationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Container(
      width: ScreenSize.blockSizeHorizontal * 100,
      height: ScreenSize.blockSizeVertical * 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30,
              children: <Widget>[
                Text(
                  "Create Message",
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: kPink),
                ),
                InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: ScreenSize.blockSizeHorizontal * 50,
                    height: ScreenSize.blockSizeVertical * 25,
                    child: Card(
                      child: _image == null
                          ? Center(
                              child: Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Colors.pink,
                              ),
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Wrap(
                    spacing: 1,
                    alignment: WrapAlignment.center,
                    direction: Axis.vertical,
                    children: <Widget>[
                      CustomTextField(
                        function: (value) {
                          if (value.isEmpty) {
                            return 'Please enter title to continue';
                          }
                          return null;
                        },
                        hintText: 'Enter Title',
                        lable: 'Title',
                        maxLine: 1,
                        fieldHeight: ScreenSize.blockSizeVertical * 6,
                        controller: controllerTitle,
                      ),
                      CustomTextField(
                          function: (value) {
                            if (value.isEmpty) {
                              return 'Please enter body to continue';
                            }
                            return null;
                          },
                          hintText: 'Enter Text',
                          lable: 'Body',
                          maxLine: 5,
                          fieldHeight: ScreenSize.blockSizeVertical * 15,
                          controller: controllerBody),
                    ],
                  ),
                ),
                RaisedButton.icon(
                  onPressed: () {
                    createSnackBar('Please Wait', Colors.blue);
                    if (_image == null ||
                        controllerTitle.text.isEmpty ||
                        controllerBody.text.isEmpty) {
                      createSnackBar(
                          'Please select an image', Colors.redAccent);
                    } else {
                      _uploadBloc.add(
                        UploadImage(
                            image: _image,
                            num: num,
                            context: context,
                            title: controllerTitle.text,
                            body: controllerBody.text),
                      );
//
                    }
//
                  },
                  icon: Icon(Icons.send),
                  label: Text("Send"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void createSnackBar(String content, Color color) {
    final snackbar = SnackBar(
      backgroundColor: color,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(content),
          CircularProgressIndicator(),
        ],
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

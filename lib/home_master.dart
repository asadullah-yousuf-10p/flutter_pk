import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pk/about/about_detail.dart';
import 'package:flutter_pk/caches/user.dart';
import 'package:flutter_pk/global.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_pk/registration/registration.dart';
import 'package:flutter_pk/venue/venue_detail.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_pk/schedule/schedule_page.dart';

class HomePageMaster extends StatefulWidget {
  @override
  HomePageMasterState createState() => HomePageMasterState();
}

class HomePageMasterState extends State<HomePageMaster> {
  int _selectedIndex = 0;
  String floatingButtonLabel = 'Register';
  IconData floatingButtonIcon = Icons.group_work;
  bool _isLoading = false;
  bool _isUserPresent = false;
  User _user = new User();
  List<Widget> widgets = <Widget>[
    SchedulePage(),
    Center(
      child: Text('Hello two'),
    ),
    AboutDetailPage()
  ];

  @override
  void initState() {
    super.initState();
    _setUser(true);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      sized: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _isLoading
            ? null
            : FloatingActionButton.extended(
                onPressed: _floatingButtonTapModerator,
                icon: Icon(floatingButtonIcon),
                label: Text(floatingButtonLabel),
              ),
        body: Stack(
          children: <Widget>[
            widgets.elementAt(_selectedIndex),
            _isLoading ? FullScreenLoader() : Container()
          ],
        ),
        bottomNavigationBar: _isLoading
            ? null
            : BottomNavigationBar(
                onTap: (value) {
                  floatingButtonLabel =
                      _user.isRegistered ? 'Scan QR' : 'Register';
                  floatingButtonIcon = _user.isRegistered
                      ? Icons.center_focus_weak
                      : Icons.group_work;
                  if (value == 2) {
                    floatingButtonLabel = 'Venue';
                    floatingButtonIcon = Icons.location_on;
                  }
                  if (value != 1)
                    setState(() {
                      _selectedIndex = value;
                    });
                },
                currentIndex: _selectedIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.date_range), title: Text('Schedule')),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.transparent,
                      ),
                      title: Text(' ')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline), title: Text('About')),
                ],
              ),
      ),
    );
  }

  void _floatingButtonTapModerator() {
    if (_selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VenueDetailPage(),
        ),
      );
    } else if (_user.isRegistered) {
      if (!_isUserPresent) {
        if (DateTime.now().isBefore(eventDateTimeCache.eventDateTime)) {
          Alert(
            context: context,
            type: AlertType.info,
            title: "Information!",
            desc: "You will be able to scan a QR on the event day!\nCheers!",
            buttons: [
              DialogButton(
                child: Text("Cool!",
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                        )),
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ).show();
        } else {
          _scanQr();
        }
      } else {
        Alert(
          context: context,
          type: AlertType.info,
          title: "Information!",
          desc: "You are already marked present! \nEnjoy the event!",
          buttons: [
            DialogButton(
              child: Text("Cool!",
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                      )),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      }
    } else {
      _navigateToRegistration(context);
    }
  }

  Future<String> _scanQr() async {
    try {
      String qrDataString = await BarcodeScanner.scan();
      print(qrDataString);
      if (qrDataString == GlobalConstants.qrKey) {
        setState(() {
          _isLoading = true;
        });
        DocumentReference attendanceReference = Firestore.instance
            .collection(FireStoreKeys.attendanceCollection)
            .document(FireStoreKeys.dateReferenceString);

        CollectionReference attendeeCollectionReference =
            attendanceReference.collection(FireStoreKeys.attendeesCollection);

        int attendanceCount;
        await Firestore.instance
            .collection(FireStoreKeys.attendanceCollection)
            .document(FireStoreKeys.dateReferenceString)
            .get()
            .then((onValue) {
          attendanceCount = onValue['attendanceCount'];
        });

        await attendanceReference
            .setData({'attendanceCount': attendanceCount + 1}, merge: true);

        await attendeeCollectionReference.document(userCache.user.id).setData(
          {'userName': userCache.user.name},
          merge: true,
        );
        CollectionReference reference =
            Firestore.instance.collection(FireStoreKeys.userCollection);

        await reference
            .document(userCache.user.id)
            .setData({"isPresent": true}, merge: true);
        _setUser(true);
        Alert(
          context: context,
          type: AlertType.success,
          title: "Yayy!",
          desc: "You have been marked present! Enjoy the event!",
          buttons: [
            DialogButton(
              child: Text("Cool!",
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                      )),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  _isUserPresent = true;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Oops!",
          desc: "Looks like you scanned an invalid QR",
          buttons: [
            DialogButton(
              child: Text("Dismiss",
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                      )),
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ).show();
      }
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
            },
          )
        ],
      ).show();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _navigateToRegistration(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
        fullscreenDialog: true,
      ),
    );
    var user =
        await userCache.getCurrentUser(userCache.user.id, useCached: false);
    setState(() {
      _user = user;
    });
    _setUser(false);
  }

  Future _setUser(bool useCached) async {
    var user = await userCache.getCurrentUser(
      userCache.user.id,
      useCached: useCached,
    );
    setState(() {
      _user = user;
      _isUserPresent = user.isPresent;
      floatingButtonLabel = _user.isRegistered ? 'Scan QR' : 'Register';
      floatingButtonIcon =
          _user.isRegistered ? Icons.center_focus_weak : Icons.group_work;
    });
  }
}

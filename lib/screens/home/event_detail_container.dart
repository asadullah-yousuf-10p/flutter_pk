import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pk/screens/home_tabs/EventDetailPage.dart';
import 'package:flutter_pk/screens/home_tabs/sponsor_grid.dart';
import 'package:flutter_pk/helpers/AlertDialog.dart';
import 'package:flutter_pk/profile/model.dart';
import 'package:flutter_pk/profile/profile_dialog.dart';
import 'package:flutter_pk/bloc/event_bloc/model.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/screens/drawer_tabs/incoming_registrations_page.dart';
import 'package:flutter_pk/screens/drawer_tabs/AboutWtq.dart';
import 'package:flutter_pk/screens/drawer_tabs/Archive.dart';
import 'package:flutter_pk/screens/drawer_tabs/BuyTicket.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/FirebaseNotification.dart';
import 'package:flutter_pk/widgets/WtqAppbarTitle.dart';
import 'package:flutter_pk/widgets/WtqDrawerItem.dart';
import 'package:flutter_pk/widgets/WtqNotification.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_pk/screens/home_tabs/schedule_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EventDetailContainerStream extends StatefulWidget {
  @override
  _EventDetailContainerStreamState createState() =>
      _EventDetailContainerStreamState();
}

class _EventDetailContainerStreamState
    extends State<EventDetailContainerStream> {
  final EventBloc bloc = new EventBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventDetails>(
      stream: bloc.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: FullScreenLoader(),
          );
        }
        var events = snapshot.data;

        return EventDetailContainer(events);
      },
    );
  }
}

class EventDetailContainer extends StatefulWidget {
  final EventDetails event;

  EventDetailContainer(this.event);

  @override
  EventDetailContainerState createState() {
    return new EventDetailContainerState();
  }
}

class EventDetailContainerState extends State<EventDetailContainer>
    with SingleTickerProviderStateMixin {
  List<String> titleName = [
    'WTQ Home',
    'Event Schedule',
    'Sponsors',
    'Buy Ticket'
  ];

  int _selectedIndex = 0;
  String floatingButtonLabel = 'REGISTER';
  IconData floatingButtonIcon = Icons.group_work;
  bool _isLoading = false;
  String title = 'WTQ Home';

  //bool _isUserPresent = false;
  User _user = new User();
  List<Widget> tabPages;
  TabController _tabController;
  CustomAlertDialog dialog;

  final FirebaseNotifications firebaseNotifications = new FirebaseNotifications();

  @override
  void initState() {
    super.initState();
    dialog = CustomAlertDialog();
    tabPages = <Widget>[
      EventDetailPage(event: widget.event),
      SchedulePage(widget.event.id),
      SponsorGrid(widget.event.id),
      BuyTicket(),
    ];
    _tabController = TabController(
      length: tabPages.length,
      initialIndex: 0,
      vsync: this,
    )..addListener(
        () => setState(() {
          _selectedIndex = _tabController.index;
        }),
      );

    _setUser(true);
    eventDateTimeCache.setDateTime(widget.event.date);

    firebaseNotifications.setUpFirebase(context, widget.event.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  void launchURL() async {
    const url = 'mailto:wtq@10pearls.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Sorry!",
        desc: "Looks like there is a problem with email app, Please contact us at wtq@10pearls.com.",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
    ).show();
      
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: WtqAppbarTitle(title: title),
        actions: <Widget>[WtqNotification(id: widget.event.id)],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
            accountName: Text(
              _user.name == null ? "" : toBeginningOfSentenceCase(_user.name),
              style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: Colors.white, fontSize: 20, letterSpacing: -0.15),
            ),
            accountEmail: Text(
                _user.mobileNumber == null ? "" : _user.mobileNumber,
                style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.white, fontSize: 12, letterSpacing: -0.15)),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage(_user.photoUrl == null ? "" : _user.photoUrl),
            ),
          ),
          WtqDrawerItem(
              title: 'Why Participate',
              iconData: FontAwesomeIcons.spa,
              tap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutWtq(),
                  ),
                );
              }),
          WtqDrawerItem(
              title: 'Archive',
              iconData: FontAwesomeIcons.photoVideo,
              tap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Archive(),
                  ),
                );
              }),
          WtqDrawerItem(
              title: 'Contact Us',
              iconData: FontAwesomeIcons.mailBulk,
              tap: launchURL),
          WtqDrawerItem(
              title: 'Logout',
              iconData: FontAwesomeIcons.signOutAlt,
              tap: () {
                signOut(context);
              }),
          widget.event.isManagedBy(userCache.user.id)
              ? WtqDrawerItem(
                  title: 'Admin',
                  iconData: FontAwesomeIcons.userCheck,
                  tap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IncomingRegistrationsPage(widget.event),
                      ),
                    );
                  })
              : Container(),
        ],
      )),
      body: WillPopScope(
        onWillPop: () async {
          if (_selectedIndex == 1 ||
              _selectedIndex == 2 ||
              _selectedIndex == 3) {
            setState(() {
              _tabController.animateTo(0,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut);
            });
            return false;
          }
          return true;
        },
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: tabPages,
          controller: _tabController,
        ),
      ),
      bottomNavigationBar: _isLoading
          ? null
          : Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.3,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).accentColor,
                unselectedItemColor: kGreen,
                unselectedLabelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                onTap: (value) {
                  setState(() {
                    title = titleName[value];
                    _selectedIndex = value;
                    _tabController.index = _selectedIndex;
                  });
                },
                currentIndex: _selectedIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event_note),
                    title: Text(
                      'Schedule',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    title: Text(
                      'Sponsors',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_offer),
                    title: Text(
                      'Buy Ticket',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future _setUser(bool useCached) async {
    var user = await userCache.getUser(
      userCache.user.id,
      useCached: useCached,
    );
    setState(() {
      _user = user;
      //_isUserPresent = user.isPresent;
      floatingButtonLabel = _user.isRegistered ? 'SCAN QR' : 'REGISTER';
      floatingButtonIcon =
          _user.isRegistered ? Icons.center_focus_weak : Icons.group_work;
    });
  }
}

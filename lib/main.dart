import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pk/about/model.dart';
import 'package:flutter_pk/caches/user.dart';
import 'package:flutter_pk/contribution/contribution_dialog.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/home_master.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pk/theme.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';
import 'package:flutter_pk/widgets/sprung_box.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprung/sprung.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pakistan',
      theme: theme,
      home: MyHomePage(title: 'Flutter Pakistan'),
      routes: {
        Routes.home_master: (context) => new HomePageMaster(),
        Routes.main: (context) => MyHomePage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  bool _showSwipeText = false;
  bool _isFetchingSharedPreferences = false;
  String sponsorImageUrl = '';

  @override
  void initState() {
    super.initState();

    Firestore.instance.settings(
      timestampsInSnapshotsEnabled: true,
    );

    _loadData();
  }

  void _loadData() async {
    setState(() => _isFetchingSharedPreferences = true);
    try {
      final sharedPrefsFuture = sharedPreferences;
      final sponsoredImageFuture = _getSponsorImageUrl();
      final waitFuture = Future.delayed(Duration(seconds: 5));
      final results = await Future.wait(
          [sharedPrefsFuture, sponsoredImageFuture, waitFuture]);
      await _loadUserFromPrefs(results);
      setState(() => sponsorImageUrl = results[1]);
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
        _isFetchingSharedPreferences = false;
        _showSwipeText = true;
      });
    }
  }

  Future _loadUserFromPrefs(List results) async {
    final SharedPreferences prefs = results[0];
    var userId = prefs.get(SharedPreferencesKeys.firebaseUserId);
    if (userId != null) {
      await userCache.getCurrentUser(userId);
      await Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home_master,
        ModalRoute.withName(Routes.main),
      );
    }
  }

  Future<String> _getSponsorImageUrl() async {
    var document = await Firestore.instance
        .collection(FireStoreKeys.sponsorsCollection)
        .where("type", isEqualTo: 0)
        .getDocuments();
    Sponsor data = Sponsor.fromMap(document.documents.first.data);
    return data.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: _buildBody(context),
        ),
        _isLoading ? FullScreenLoader() : Container()
      ],
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: new Swiper.children(
        autoplay: false,
        loop: false,
        physics: _isFetchingSharedPreferences
            ? NeverScrollableScrollPhysics()
            : ScrollPhysics(),
        pagination: _isFetchingSharedPreferences
            ? SwiperPagination()
            : new SwiperPagination(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                builder: new DotSwiperPaginationBuilder(
                    color: Theme.of(context).hintColor,
                    activeColor: Theme.of(context).primaryColor,
                    size: 10.0,
                    activeSize: 15.0),
              ),
        children: <Widget>[
          _buildFirstSwiperControlPage(context),
          _buildSecondSwiperControlPage(context),
        ],
      ),
    );
  }

  Center _buildSecondSwiperControlPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 64.0, right: 64.0),
            child: _isLoading
                ? Container()
                : Image(
                    image: AssetImage('assets/wtq_splash.png'),
                  ),
          ),
          Column(
            children: <Widget>[
              Text(
                'Register | Attend | Build',
                style: Theme.of(context).textTheme.title,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0),
                child: Text(
                  'Get information about events, their agendas and register yourself as an attendee',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                child: RaisedButton(
                  onPressed: _handleSignIn,
                  textColor: Colors.white,
                  child: Text('Get started'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Center _buildFirstSwiperControlPage(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SprungBox(
            damped: Damped.critically,
            sponsorImageUrl: sponsorImageUrl,
            callback: (bool value) {},
          ),
          Column(
            children: <Widget>[
              Text(
                'Welcome to Women Tech Quest',
                style: Theme.of(context).textTheme.title,
              ),
              AnimatedCrossFade(
                crossFadeState: _showSwipeText
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 800),
                firstChild: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text('Swipe left to proceed'),
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    'Please wait ...',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _handleSignIn() async {
    final SharedPreferences prefs = await sharedPreferences;
    userCache.clear();
    prefs.clear();
    setState(() => _isLoading = true);
    try {
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = await auth.signInWithCredential(credential);

      CollectionReference reference =
          Firestore.instance.collection(FireStoreKeys.userCollection);

      await reference.document(user.uid).get().then((snap) async {
        if (!snap.exists) {
          User _user = User(
              name: user.displayName,
              mobileNumber: user.phoneNumber,
              id: user.uid,
              photoUrl: user.photoUrl,
              email: user.email);

          await reference
              .document(user.uid)
              .setData(_user.toJson(), merge: true);
        }
      });
      prefs.setString(SharedPreferencesKeys.firebaseUserId, user.uid);

      await userCache.getCurrentUser(user.uid);

      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home_master,
        ModalRoute.withName(Routes.main),
      );
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
      setState(() => _isLoading = false);
    }
  }
}

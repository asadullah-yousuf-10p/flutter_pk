import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/about/model.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/widgets/about.dart';
import 'package:flutter_pk/widgets/custom_app_bar.dart';

class AboutDetailPage extends StatefulWidget {
  @override
  AboutDetailState createState() => AboutDetailState();
}

class AboutDetailState extends State<AboutDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomAppBar(
              title: 'About',
            ),
            _buildBody()
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: _streamBuilder(FireStoreKeys.sponsorsCollection),
    );
  }

  StreamBuilder<QuerySnapshot> _streamBuilder(String parameter) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(FireStoreKeys.sponsorsCollection)
          .orderBy('type')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Text(
              'Nothing found!',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    if (snapshot == null) return Container();
    if (snapshot.length < 1) return Container();
    List<String> goldSponsors = extractSponsors(snapshot, 0);
    List<String> silverSponsors = extractSponsors(snapshot, 1);
    List<String> bronzeSponsors = extractSponsors(snapshot, 2);

    return ListView.separated(
      separatorBuilder: (context, int) {
        return Divider(
          color: Colors.transparent,
        );
      },
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Event Sponsors',
                style: Theme.of(context).textTheme.title,
              ),
              GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  childAspectRatio: 2.0,
                  children: goldSponsors.map(
                    (String url) {
                      return sponsorWidget(url);
                    },
                  ).toList()),
            ],
          );
        }
        if (index == 1) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Competetition Sponsors',
                style: Theme.of(context).textTheme.title,
              ),
              GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  children: silverSponsors.map(
                    (String url) {
                      return sponsorWidget(url);
                    },
                  ).toList()),
            ],
          );
        }
        if (index == 2) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Partners',
                style: Theme.of(context).textTheme.title,
              ),
              GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 2.0,
                  children: bronzeSponsors.map(
                    (String url) {
                      return sponsorWidget(url);
                    },
                  ).toList()),
            ],
          );
        }
        if (index == 3) {
          return AboutEvent();
        }
      },
      itemCount: 4,
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final sponsors = Sponsor.fromSnapshot(data);
    var imageUrl = sponsors.imageUrl;
    var type = sponsors.type;

    if (imageUrl == null || type == null)
      return Center(
        child: Text(
          'Nothing found!',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
  }

  List<String> extractSponsors(List<DocumentSnapshot> snapshot, int type) {
    List<String> extractedList = new List<String>();
    for (int i = 0; i < snapshot.length; i++) {
      Sponsor data = Sponsor.fromSnapshot(snapshot[i]);
      if (data.type == type) {
        extractedList.add(data.imageUrl);
      }
    }
    return extractedList;
  }

  Widget sponsorWidget(String url) {
    return Container(
      padding: EdgeInsets.all(10),
      child: new Card(
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Image.network(url),
        ),
      ),
    );
  }
}

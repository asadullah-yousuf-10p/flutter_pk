import 'dart:convert' as json;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/helpers/formatters.dart';
import 'package:flutter_pk/models/messages/MessagesModel.dart';
import 'package:flutter_pk/provider/Preference.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:provider/provider.dart';

class MessageBoard extends StatefulWidget {
  final String eventId;

  MessageBoard(
    this.eventId, {
    Key key,
  }) : super(key: key);

  @override
  _MessageBoardState createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoard> {

  @override
  void initState() {
//    _getInitializePreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    MessageModel messageModel = MessageModel();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: Theme.of(context)
              .textTheme
              .subtitle
              .copyWith(fontSize: 19, color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(
                      '${FireStoreKeys.eventCollection}/${widget.eventId}/${FireStoreKeys.messageCollection}')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    width: ScreenSize.blockSizeHorizontal * 100,
                    height: ScreenSize.blockSizeVertical * 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text('No Incoming Messages'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(

                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.transparent,
                        ),
                        itemBuilder: (context, index) {
                          final pref = Provider.of<Preference>(context);
                          pref.setStringValue(value: DateTime.now().toString());
//                          preferences.setString('lastDate',
//                              snapshot.data.documents.first.data['date']);
                          messageModel = MessageModel.fromJson(
                            json.jsonDecode(
                              json.jsonEncode(
                                  snapshot.data.documents[index].data),
                            ),
                          );
                          return Container(
                            width: ScreenSize.blockSizeHorizontal * 100,
                            //height: ScreenSize.blockSizeVertical * 30,
                            child: Card(
                              elevation: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  messageModel.imageUrl.isEmpty
                                      ? Container()
                                      : Container(
                                          height:
                                              ScreenSize.blockSizeVertical * 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  messageModel.imageUrl),
                                            ),
                                          ),
                                        ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(11),
                                    isThreeLine: true,
                                    title: Text(
                                      messageModel.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subhead
                                          .copyWith(
                                              letterSpacing: -0.13,
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .accentColor),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            messageModel.text,
                                            softWrap: true,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle
                                                .copyWith(
                                                    letterSpacing: -0.13,
                                                    color: kBlueDark,
                                                    fontSize: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                          ),
                                          Text(
                                              formatDate(
                                                  messageModel.date,
                                                  DateFormats
                                                      .shortUiDateTimeFormat),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle
                                                  .copyWith(
                                                      color: kBlueDark,
                                                      fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

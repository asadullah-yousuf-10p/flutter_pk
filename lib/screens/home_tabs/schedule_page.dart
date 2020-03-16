import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/global.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/models/schedule/ScheduleModel.dart';
import 'package:flutter_pk/screens/home_tabs/schedule_sub_page/EventDetail.dart';
import 'package:flutter_pk/widgets/WtqEventCard.dart';

class SchedulePage extends StatefulWidget {
  final String eventId;

  SchedulePage(this.eventId);

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          ScreenSize.blockSizeHorizontal * 100,
          ScreenSize.blockSizeVertical * 20,
        ),
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.subtitle,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xffb3ffffff),
            tabs: [
              Tab(
                text: "Karachi",
              ),
              Tab(
                text: "Islamabad",
              ),
              Tab(
                text: "Lahore",
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          CitySchedule(
            widget.eventId,
            city: 'Karachi',
          ),
          CitySchedule(
            widget.eventId,
            city: 'Islamabad',
          ),
          CitySchedule(
            widget.eventId,
            city: 'Lahore',
          )
        ],
      ),
    );
  }
}

class CitySchedule extends StatelessWidget {
  final String eventId;
  final String city;

  CitySchedule(this.eventId, {this.city = 'Karachi'});

  @override
  Widget build(BuildContext context) {
    ScheduleModel scheduleModel = ScheduleModel();
    ScreenSize().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        width: ScreenSize.blockSizeHorizontal * 100,
        height: ScreenSize.blockSizeVertical * 100,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(
                  '${FireStoreKeys.eventCollection}/$eventId/${FireStoreKeys.sessionCollection}')
              .orderBy('startDateTime')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  scheduleModel = ScheduleModel.fromJson(
                      snapshot.data.documents[index].data);

                  if (city == scheduleModel.city) {
                    return InkWell(
                      onTap: () {                        
                        if(!snapshot.data.documents[index].data['shouldOpenDetail']) {
                          //no action
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetail(
                              speakerId: snapshot
                                  .data.documents[index].data['speakerId'],
                              title:
                                  snapshot.data.documents[index].data['title'],
                              description: snapshot
                                  .data.documents[index].data['description'],
                              startDate: snapshot
                                  .data.documents[index].data['startDateTime'],
                              endDate: snapshot
                                  .data.documents[index].data['endDateTime'],
                            ),
                          ),
                        );
                      },
                      child: WtqEventCard(
                        title: scheduleModel.title,
                        color: Theme.of(context).accentColor,
                        startDateTime: scheduleModel.startDateTime,
                        endDateTime: scheduleModel.endDateTime,
                        canOpenDetail: scheduleModel.shouldOpenDetail,
                      ),
                    );
                  }
                  return Container();
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

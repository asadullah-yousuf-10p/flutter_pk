import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/bloc/event_bloc/model.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/screens/apbar_widget/messages_board.dart';
import 'package:flutter_pk/widgets/ContextCards.dart';
import 'package:flutter_pk/widgets/WtqCaption.dart';
import 'package:flutter_pk/widgets/WtqDetail.dart';
import 'package:flutter_pk/widgets/WtqEvent.dart';
import 'package:flutter_pk/widgets/WtqTitle.dart';
import 'package:flutter_pk/widgets/full_screen_loader.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class EventDetailPage extends StatefulWidget {
  final EventBloc bloc = new EventBloc();
  final EventDetails event;

  EventDetailPage({@required this.event});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return StreamBuilder<EventDetails>(
      stream: widget.bloc.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: FullScreenLoader(),
          );
        }

        return ListView(
          children: <Widget>[
            Hero(
              tag: 'banner_${widget.event.id}',
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: widget.event.bannerUrl[0],
                    imageBuilder: (context, imageProvider) {
                      return Swiper(
                        autoplay: true,
                        pagination: SwiperPagination(),
                        itemCount: widget.event.bannerUrl.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.event.bannerUrl[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Text(error.toString());
                    },
                    placeholder: (context, url) {
                      return Container(
                        width: 10,
                        height: 10,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              child: WtqCaption(
                caption: 'Women Tech Quest - 2020',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: WtqTitle(
                title: 'Participate In Competitions',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 22),
              child: ContestCards(widget.event.id),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: WtqTitle(
                title: widget.event.eventTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 22),
              child: WtqDetail(description: widget.event.description),
            ),
            Container(
              width: ScreenSize.blockSizeHorizontal*100,
              //height: ScreenSize.blockSizeVertical*50,
              child: WtqEvent(),
            ),
          ],
        );
      },
    );
  }
}

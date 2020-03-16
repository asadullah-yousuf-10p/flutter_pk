import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/bloc/event_bloc/model.dart';
import 'package:flutter_pk/screens/home_tabs/sponsors_sub_page/partner_grid.dart';
import 'package:flutter_pk/helpers/LaunchUrl.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/widgets/WtqCaption.dart';
import 'package:flutter_pk/widgets/WtqCard.dart';
import 'package:flutter_pk/widgets/WtqTitle.dart';

class SponsorGrid extends StatefulWidget {
  const SponsorGrid(
    this.eventId, {
    Key key,
  }) : super(key: key);

  final String eventId;

  @override
  _SponsorGridState createState() => _SponsorGridState();
}

class _SponsorGridState extends State<SponsorGrid> {
  final bloc = SponsorBloc();
  LaunchUrl launchUrl;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    return StreamBuilder<List<Sponsor>>(
      stream: bloc.getSponsors(widget.eventId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var sponsors = snapshot.data;
        return ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            WtqTitle(
              title: 'SPONSORS',
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sponsors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9
              ),
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: sponsors[index].imageUrl,
                  imageBuilder: (context, imageProvider) {
                    launchUrl = LaunchUrl(sponsors[index].link);
                    return InkWell(
                      child: WtqCard(
                        imageUrl: sponsors[index].imageUrl,
                        type: cardType.networkImage,
                        fit: BoxFit.scaleDown,
                        caption: sponsors[index].name,
                      ),
                      onTap: launchUrl.urlLauncher,
                    );
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WtqTitle(
                  title: 'STRATEGIC AND COMMUNITY PARTNERS',
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            PartnerGrid(widget.eventId),
          ],
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/bloc/event_bloc/model.dart';
import 'package:flutter_pk/helpers/LaunchUrl.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/widgets/WtqCard.dart';

class PartnerGrid extends StatefulWidget {
  const PartnerGrid(
    this.eventId, {
    Key key,
  }) : super(key: key);

  final String eventId;

  @override
  _PartnerGridState createState() => _PartnerGridState();
}

class _PartnerGridState extends State<PartnerGrid> {
  final bloc = PartnerBloc();
  LaunchUrl launchUrl;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return StreamBuilder<List<Partner>>(
      stream: bloc.getPartners(widget.eventId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var partners = snapshot.data;
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: partners.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9
          ),
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: partners[index].imageUrl,
              imageBuilder: (context, imageProvider) {
                launchUrl = LaunchUrl(partners[index].link);
                return InkWell(
                  onTap: launchUrl.urlLauncher,
                  child: WtqCard(
                    imageUrl: partners[index].imageUrl,
                    type: cardType.networkImage,
                    caption: partners[index].name,
                    fit: BoxFit.scaleDown,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

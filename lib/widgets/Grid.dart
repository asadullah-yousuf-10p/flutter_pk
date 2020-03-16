import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqCard.dart';

class Grid extends StatelessWidget {
  final int length;
  final String imageUrl;
  final String name;

  Grid({@required this.length, @required this.imageUrl, @required this.name});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: this.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: this.imageUrl,
          imageBuilder: (context, imageProvider) {
            return Container(
              width: ScreenSize.blockSizeHorizontal * 100,
              height: ScreenSize.blockSizeVertical * 25,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Container(),
                  Text(
                    this.name,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: kGreen,
                        ),
                  ),
                ],
              ),
            );
          },
        );
//            return GridTile(
//              child: Image.network(partners[index].imageUrl),
//            );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_pk/helpers/ScreenSize.dart';
import 'package:flutter_pk/theme/theme.dart';
import 'package:flutter_pk/widgets/WtqCaption.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum cardType { assetImage, networkImage }

class WtqCard extends StatelessWidget {
  final String imageUrl;
  final cardType type;
  final IconData data;
  final Function navigate;
  final BoxFit fit;
  final String assetUrl;
  final String caption;
  final double iconScale;

  WtqCard(
      {
      this.imageUrl = 'https://firebasestorage.googleapis.com/v0/b/wtq2020-41291.appspot.com/o/sponsors%2Fno-image-placeholder.png?alt=media&token=feed77d3-38a3-4473-a8ab-4dd1ac2badf7',
      this.type = cardType.assetImage,
      this.data = FontAwesomeIcons.image,
      this.navigate,
      this.fit = BoxFit.contain,
      this.assetUrl,
      this.caption,
      this.iconScale = 1 
      });

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    if (cardType.networkImage == this.type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff1e79cbbd),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.network(
                  imageUrl,
                  scale: this.iconScale,
                  fit: fit,
                  )
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Container(
              child: WtqCaption(
                caption: this.caption,
              )),
        ],
      );
    }

    if (cardType.assetImage == this.type) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff1e79cbbd),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Center(
                child: Image.asset(
                  assetUrl,
                  scale: 2,
                  fit: fit,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Container(
              child: WtqCaption(
                caption: this.caption,
              )
            ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: kGreen.withOpacity(0.3),
              offset: Offset(1, 1),
              blurRadius: 10,
              spreadRadius: 0.2),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Center(
        child: Image.network(
          imageUrl,
          scale: 2,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}

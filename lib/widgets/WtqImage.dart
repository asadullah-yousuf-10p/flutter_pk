import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WtqImage extends StatelessWidget {
  final String imageUrl;

  WtqImage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: this.imageUrl,
        imageBuilder: (context, imageProvider) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              this.imageUrl,
              fit: BoxFit.cover,
            ),
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
    );
  }
}

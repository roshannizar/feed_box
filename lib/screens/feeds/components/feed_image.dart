import 'package:flutter/material.dart';

class FeedImage extends StatelessWidget {
  final String url;
  FeedImage({this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network('$url', loadingBuilder:
                    (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  }
                }),
              ),
            );
  }
}
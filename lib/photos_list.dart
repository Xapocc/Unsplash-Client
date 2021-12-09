import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'photo.dart';
import 'package:flutter/rendering.dart';
import 'image_preview_route.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos, required this.offset}) : super(key: key);

  final List<Photo> photos;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: ScrollController(initialScrollOffset: offset),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImagePreviewRoute(url: photos[index].fullImageUrl)),
                      );
                    },
                  child: Image.network(photos[index].regularImageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                // Image itself
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 48.0),
                  child: Row( // Info about author
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect( // Rounding profile image corners to circle
                        borderRadius: const BorderRadius.all(Radius.circular(90.0)),
                        child: Image.network(photos[index].userProfileImageUrl), // Author`s profile image
                      ),
                      Padding( // Padding between profile image and username
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                        child: Text(photos[index].userName),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
  }
}
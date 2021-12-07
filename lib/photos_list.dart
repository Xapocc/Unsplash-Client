import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'photo.dart';
import 'package:flutter/rendering.dart';


class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos}) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute(url: photos[index].fullImageUrl)),
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


  class SecondRoute extends StatelessWidget {
    const SecondRoute({Key? key, required this.url}) : super(key: key);

    final String url;

    @override
    Widget build(BuildContext context) {
      return Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(80),
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.network(url),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      child: const Icon(Icons.arrow_back),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white30,
                      hoverColor: Colors.black12,
                      onPressed: () { Navigator.pop(context); },
                    ),
                  ),
                ],
              )
            ]
        ),
      );
    }
  }
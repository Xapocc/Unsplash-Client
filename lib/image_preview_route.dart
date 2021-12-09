import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePreviewRoute extends StatelessWidget {
  const ImagePreviewRoute({Key? key, required this.url}) : super(key: key);

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
                child: Image.network(
                  url,
                  loadingBuilder: (context, child, loadingProcess) {
                    if(loadingProcess == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (context, url, error) {
                    return const Center(
                        child: Text(
                          'Something went wrong when downloading photo!\nPlease try again.',
                          style: TextStyle(color: Colors.white),
                        )
                    );
                  },
                ),
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
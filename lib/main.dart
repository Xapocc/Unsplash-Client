import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'photos_list.dart';
import 'photo.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  static const String appTitle = 'Unsplash client';
  String searchQuery = "";
  int page = 1;
  final searchQueryController = TextEditingController();
  List<Photo> photos = List<Photo>.empty();
  double listViewOffset = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
            title: const Text(appTitle),
            backgroundColor: Colors.grey[400],
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45.0))
                        ),
                        child: TextField(
                          controller: searchQueryController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      // Search button
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            page = 1;
                            searchQuery = searchQueryController.text;
                            photos.clear();
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.search),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
                          shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
                        ),
                      ),
                    ),
                  ],
              ),
            ), // search bar
            // Photo cards list
            FutureBuilder<List<Photo>>(
              future: getPhotos(http.Client(), searchQuery, page),
              builder: (context, snapshot) {

                // If something went wrong while getting photos
                if(snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Something went wrong when downloading photos!\nPlease try again.",
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }

                if (snapshot.connectionState != ConnectionState.waiting) {

                  if(photos.isEmpty || photos.last.regularImageUrl != snapshot.data!.last.regularImageUrl) {
                    photos = photos + snapshot.data!;
                  }
                  // Displaying photos
                  return Flexible(
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NotificationListener(
                        child: PhotosList(photos: photos, offset: listViewOffset),
                        onNotification: (t) {
                          if(t is ScrollEndNotification) {
                            if(t.metrics.atEdge) {
                              if(t.metrics.pixels != 0) {
                                setState(() {
                                  listViewOffset = t.metrics.pixels;
                                  page++;
                                });
                                return true;
                              }
                            }
                          }
                          return false;
                          },
                        ),
                      )
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black54,
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Photo>> getPhotos(http.Client client, String query, int page) async {

  const String baseUrl = "https://api.unsplash.com/";
  const int perPage = 8;
  const String token = "vQSKBPRQMUikr1R9STDKqad1ifJfiKQqTG7cgmB7fmw";
  final String params = "page=$page&per_page=$perPage&client_id=$token";

  bool isSearched = query=="" ? false : true;

  final response = await client.get(
      isSearched ?
      Uri.parse("${baseUrl}search/photos?query=$query&$params") :
      Uri.parse("${baseUrl}photos?$params")
  );

  return parsePhotos(response.body, isSearched);
 }

List<Photo> parsePhotos(String responseBody, bool isSearched) {
  final parsed = jsonDecode(responseBody);

  print("kek");

  return
  isSearched ?
     parsed.values.last.map<Photo>((json) => Photo.fromJson(json)).toList() :
     parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
 }
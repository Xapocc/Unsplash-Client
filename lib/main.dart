import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'photos_list.dart';
import 'photo.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String appTitle = 'Unsplash client';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
            title: Text(appTitle),
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
                        child: const TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
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
                        onPressed: () {},
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
              future: getPhotos(http.Client()),
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
                // Displaying photos
                if (snapshot.hasData) {
                  return Flexible(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PhotosList(photos: snapshot.data!),
                  ));
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

Future<List<Photo>> getPhotos(http.Client client) async {
  final response = await client.get(
      Uri.parse("https://api.unsplash.com/photos/?page=1&per_page=8&client_id=vQSKBPRQMUikr1R9STDKqad1ifJfiKQqTG7cgmB7fmw")
  );

  return compute(parsePhotos, response.body);
 }

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
 }
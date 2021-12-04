import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

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
            Row(
              children: [

              ],
            ),
          ],
        ),
      ),
    );
  }
}

// void getPhotos() async {
//   await
// }
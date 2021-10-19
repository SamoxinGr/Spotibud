import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/pages/loading_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (null), child: Text("press")),
          SizedBox(height: 30),
          TextField(
            onSubmitted: (String? code) {
              print("saved");
              getToken(code);
            },
          )
        ],
      )
    ]);
  }
}

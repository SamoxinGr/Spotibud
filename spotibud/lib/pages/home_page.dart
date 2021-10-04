import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:spotibud/src/requests/requests.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*String get_user_profile =
      'https://api.spotify.com/v1/users/mh5y1ps99zoyhsq8jaqxfb4gs';
  String access_token =
      'BQCgMdGrzdstwbztSy8Gzb3G7Nikf5v0nAdzZt6lumHxBjfn6ibdEdXQFkgSfN8CmSzByOTASZQR4jxC_IwE9pnL_tzhJDsAIMPVEGKUCtEYyz6cl1kX9Dbqe_uUqFxjzfXpbthehN74DLp-0dFoyomJYhSJ1M9lm5deOep8UE_qQUYoDcM';
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(children: [
      /*Center(
        child: Text(
          "Home",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),*/
      Center(
        child: ElevatedButton(onPressed: authorization, child: Text("press")),
      )
    ]);
  }
}

//разобраться с фьючерами, посмотреть еще раз гит Витали, сделать json запрос
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotibud/request/requests.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

import 'package:spotibud/src/requests/requests.dart';

import 'home_page.dart';

const AUTHORIZE = 'https://accounts.spotify.com/authorize';

String client_id = "6e7d62a9d6d84e3b9fb0f0eef26050f5";
String client_secret = "0891a218c5db42c6a47a062b209fe7ef";
String redirect_uri = "https://github.com/SamoxinGr/Naughty-code";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  late StreamSubscription _onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  String? token = "0";

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() async {
          print("URL changed: $url");
          if (url.startsWith('https://github.com/SamoxinGr/Naughty-code')) {
            RegExp regExp = RegExp("#access_token=(.*)");
            this.token = regExp.firstMatch(url)?.group(1);
            print("token $token");
            var acToken = await getToken(token);
            if (this.token != '0'){
              setState((){
                flutterWebviewPlugin.close();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomePage()));
              }

              );
            }
            }
        });
    };

    @override
    Widget build(BuildContext context) {
      String loginUrl = "$AUTHORIZE?client_id=$client_id&response_type=code&redirect_uri=$redirect_uri&scope=user-read-private%20user-read-email";

      return new WebviewScaffold(
          url: loginUrl,
          appBar: new AppBar(
            title: new Text("Login to Spotify..."),
          ));
    }
  });}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }}
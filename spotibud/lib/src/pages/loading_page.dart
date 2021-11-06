import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotibud/src/pages/root_app.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

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

  late StreamSubscription onDestroy;
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  String? token = '0';

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    onDestroy.cancel();
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
    onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {});

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
    });

    // Add a listener to on url changed
    _onUrlChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (mounted) {
        print("URL changed: $url");
        if (url.startsWith('https://github.com/SamoxinGr/Naughty-code')) {
          RegExp regExp = RegExp("code=(.*)");
          this.token = regExp.firstMatch(url)?.group(1);
          print(this.token);
          print('Check');
          print(token);

          var myToken = await getToken(token);
          UserSecureStorage.setTokenInStorage(myToken['access_token']);
          //await getUserTopArtists(myToken['access_token']); // временно
          //await getUserTopSongs(myToken["access_token"]);
          if (this.token != '0') {
            setState(() {
              flutterWebviewPlugin.close();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RootApp()));
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl =
        "$AUTHORIZE?client_id=$client_id&response_type=code&redirect_uri=$redirect_uri&scope=user-read-private%20user-read-email%20user-top-read%20user-follow-read";

    return WebviewScaffold(
        url: loginUrl,
        appBar: AppBar(
          title: const Text("Login to Spotify..."),
          backgroundColor: Colors.black,
          leading: Image.asset("assets/images/image.jpeg"),
        ));
  }
}

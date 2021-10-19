import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotibud/pages/home_page.dart';
//import 'package:url_launcher/url_launcher.dart';

//dynamic user_id = "mh5y1ps99zoyhsq8jaqxfb4gs";

String client_id = "6e7d62a9d6d84e3b9fb0f0eef26050f5";
String client_secret = "0891a218c5db42c6a47a062b209fe7ef";
String redirect_uri = "https://github.com/SamoxinGr/Naughty-code";

Future<Map<String, dynamic>> getToken(String? code) async {
  final Map<String, String> tokenBody = {
    "grant_type": "authorization_code",
    "client_id": client_id,
    "client_secret": client_secret,
    "code": "$code",
    "redirect_uri": 'https://github.com/SamoxinGr/Naughty-code'
  };

  final Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept": "*/*",
  };

  final Response tokenRequestResponse = await http.post(
      Uri.https('accounts.spotify.com', '/api/token'),
      headers: headers,
      body: tokenBody);
  print(tokenRequestResponse.request);

  if (tokenRequestResponse.statusCode == 200) {
    final token = await convert.jsonDecode(tokenRequestResponse.body)
        as Map<String, dynamic>;
    print("alarm");
    print(token);
    print(token['access_token']);
    print("LOOK AT ME");
    return token;
  } else {
    var statusCode = tokenRequestResponse.statusCode;
    throw Exception('Failed to get TOKEN response. Status code = $statusCode');
  }

  Future<void> tok() async {}
}

import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
//import 'package:url_launcher/url_launcher.dart';

dynamic user_id = "mh5y1ps99zoyhsq8jaqxfb4gs";

var client_id = "6e7d62a9d6d84e3b9fb0f0eef26050f5";
var client_secret = "0891a218c5db42c6a47a062b209fe7ef";
var red_uri = "https://127.0.0.1:5500/index.html";
var redirect_uri = "https://www.google.ru/";

const AUTHORIZE = 'https://accounts.spotify.com/authorize';

//Future<Map<String, dynamic>> getToken() async {}
Future<void> authorization() async {
  final url = Uri.parse(
      "$AUTHORIZE/?client_id=$client_id&response_type=code&redirect_uri=$redirect_uri&scope=user-read-private%20user-read-email&state=34fFs29kd09");
  //переделать ссылку и написать через body
  Response response = await http.get(url);
  //String urlString = url as String;
  //await launch(url);
  print("Response status: ${response.statusCode}");
  print('Headers: ${response.headers}');
  //print('Body: ${response.body}');
}

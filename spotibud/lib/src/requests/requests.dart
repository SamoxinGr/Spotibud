import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spotibud/src/requests/utils/url_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotibud/pages/home_page.dart';
//import 'package:url_launcher/url_launcher.dart';

dynamic user_id = "mh5y1ps99zoyhsq8jaqxfb4gs";

String client_id = "6e7d62a9d6d84e3b9fb0f0eef26050f5";
String client_secret = "0891a218c5db42c6a47a062b209fe7ef";
String redirect_uri = "https://github.com/SamoxinGr/Naughty-code";

const AUTHORIZE = 'https://accounts.spotify.com/authorize';

//Future<Map<String, dynamic>> getToken() async {}
Future<void> authorization() async {
  final url = Uri.parse(
      "$AUTHORIZE?client_id=$client_id&response_type=code&redirect_uri=$redirect_uri&scope=user-read-private%20user-read-email");
  //переделать ссылку и написать через body    &scope=user-read-private%20user-read-email&state=34fFs29kd09&state=34fFs29kd09
  /* Response response = await http.get(url);*/
  //String urlString = url as String;
  //await launchUniversalLink(url);
  ////print("Response status: ${response.statusCode}");
  //print('Headers: ${response.headers}');
  //print('Body: ${response.body}');
  /*final String requestTokenBody = convert.jsonEncode({
    "client_i": "d938f7d239d64003907d54e49ea451ec",
    "response_type": "code",
    "redirect_uri": "https://www.google.com",
    "state": "34fFs29kd09",
    "scope": "user-read-private"
  });*/ /*
  Response response = await http
      .get(Uri.https("accounts.spotify.com", "/authorize"), requestTokenBody);
  //final data = convert.jsonDecode(response.body) as Map<String, dynamic>;
  //print(data);
  //String token = data['code'];
  //print(token);*/

  Response response = await http.get(url);
  print({response.request});
  print("Response status: ${response.statusCode}");
  //print('Body: ${response.body}');
}
//Переходит по redirect_uri и в конце ссылки дописывает code и state

Future<Map<String, dynamic>> getToken(String? code) async {
  final String tokenBody = convert.jsonEncode({
    "grant_type": "authorization_code",
    //"client_id": client_id,
    //"client_secret": client_secret,
    "code": "$code",
    "redirect_uri": 'https://github.com/SamoxinGr/Naughty-code'
  });

  //String cl_id = base64("6e7d62a9d6d84e3b9fb0f0eef26050f5");
  //String cl_secret =convert.base64Encode("0891a218c5db42c6a47a062b209fe7ef");
  String cl_id_encoded = convert.base64.encode(convert.utf8.encode(client_id));
  String cl_secret_encoded =
      convert.base64.encode(convert.utf8.encode(client_secret));

  final Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": "Basic $cl_id_encoded:$cl_secret_encoded",
    //"Accept": "application/json",
  };

  final Response tokenRequestResponse = await http.post(
      Uri.https('accounts.spotify.com', '/api/token'),
      headers: headers,
      body: tokenBody);
  print(tokenRequestResponse.request);

  if (tokenRequestResponse.statusCode == 200) {
    final token =
        convert.jsonDecode(tokenRequestResponse.body) as Map<String, dynamic>;
    print("alarm");
    return token;
  } else {
    var statusCode = tokenRequestResponse.statusCode;
    throw Exception('Failed to get TOKEN response. Status code = $statusCode');
  }

  Future<void> tok() async {}
}

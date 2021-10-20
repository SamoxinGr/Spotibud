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

  if (tokenRequestResponse.statusCode != 200) {
    var statusCode = tokenRequestResponse.statusCode;
    throw Exception('Failed to get TOKEN response. Status code = $statusCode');
  } else {
    final token = await convert.jsonDecode(tokenRequestResponse.body)
        as Map<String, dynamic>;
    print("alarm");
    print(token);
    print(token['access_token']);
    //dynamic accessToken = token['access_token'];
    print("LOOK AT ME");
    return token;
  }
}

Future<Map<String, dynamic>> getUser(dynamic token) async {
  final Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": "Bearer $token",
    "Accept": "*/*",
  };
  final Response getUserResponse =
      await http.get(Uri.https("api.spotify.com", "/v1/me"), headers: headers);
  print(getUserResponse.request);
  if (getUserResponse.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    final user_info =
        await convert.jsonDecode(getUserResponse.body) as Map<String, dynamic>;
    print(user_info);
    print("UUUUPPPPP");
    return user_info;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getUserResponse.statusCode;
    throw Exception('Failed to get USER response. Status code = $statusCode');
  }
}

//REFRESH TOKEN
Future<Map<String, dynamic>> refreshToken(dynamic refreshToken) async {
  final Map<String, String> refreshTokenBody = {
    "grant_type": "refresh_token",
    "client_id": client_id,
    "client_secret": client_secret,
    "refresh_token": refreshToken,
  };

  final Map<String, String> refreshTokenHeaders = {
    "Content-Type": "application/x-www-form-urlencoded",
  };

  final Response refreshTokenResponse = await http.post(
      Uri.https("accounts.spotify.com", "api/token"),
      headers: refreshTokenHeaders,
      body: refreshTokenBody);
  print(refreshTokenResponse.request);

  if (refreshTokenResponse.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    final refreshToken = await convert.jsonDecode(refreshTokenResponse.body)
        as Map<String, dynamic>;
    print(refreshToken);
    print("REFRESED");
    return refreshToken;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = refreshTokenResponse.statusCode;
    throw Exception(
        'Failed to REFRESH TOKEN response. Status code = $statusCode');
  }
}

// ТОП 5 артистов в споти
Future<Map<String, dynamic>> getUserTopArtist(dynamic token) async {
  final Map<String, String> getUserAristHeaders = {
    "Accept": "application/json",
    "time_range": "long_term&limit=5",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  final Response getUserTopArtistResponse = await http.get(
      Uri.https('api.spotify.com', '/v1/me/top/artists'),
      headers: getUserAristHeaders);

  print(getUserTopArtistResponse.request);

  if (getUserTopArtistResponse.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    final artists_info = convert.jsonDecode(getUserTopArtistResponse.body)
        as Map<String, dynamic>;
    //print(artists_info);
    print("ARTISTS");
    print(artists_info['items'][0]['name']);
    print(artists_info['items'][1]['name']);
    print(artists_info['items'][2]['name']);
    print(artists_info['items'][3]['name']);
    print(artists_info['items'][4]['name']);
    return artists_info;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getUserTopArtistResponse.statusCode;
    throw Exception(
        'Failed to get Arists USER response. Status code = $statusCode');
  }
}

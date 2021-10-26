import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spotibud/src/utils/secure_storage.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotibud/pages/home_page.dart';
import 'package:spotibud/src/objects/topOfArtists.dart' as artists;
import 'package:spotibud/src/objects/topOfSongs.dart' as songs;
import 'package:spotibud/src/auth.dart' as auth;

String redirect_uri = "https://github.com/SamoxinGr/Naughty-code";

Future<Map<String, dynamic>> getTokenAsOwner(String? code) async {
  final Map<String, String> tokenBody = {
    "grant_type": "authorization_code",
    "client_id": auth.client_id,
    "client_secret": auth.client_secret,
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
    print(token);
    print(token['access_token']);
    //dynamic accessToken = token['access_token'];
    print("LOOK AT ME");
    UserSecureStorage.setTokenAsOwnerInStorage(token['access_token']);
    return token;
  }
}

//get token as owner
Future<Map<String, dynamic>> getToken(String? code) async {
  final Map<String, String> tokenBody = {
    "grant_type": "authorization_code",
    "client_id": auth.client_id,
    "client_secret": auth.client_secret,
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
    UserSecureStorage.setTokenAsOwnerInStorage(token['access_token']);
    return token;
  }
}

//User INFO
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
    "client_id": auth.client_id,
    "client_secret": auth.client_secret,
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

// ТОП 10 artists
Future<List<dynamic>> getUserTopArtists(dynamic token) async {
  final Map<String, String> getUserArtistbody = {
    'time_range': 'short_term',
    'limit': '10',
    'offset': '0',
  };

  final Map<String, String> getUserAristHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  final Response getUserTopArtistResponse = await http.get(
      Uri.https('api.spotify.com', '/v1/me/top/artists', getUserArtistbody),
      headers: getUserAristHeaders);

  //print(getUserTopArtistResponse.request);

  if (getUserTopArtistResponse.statusCode == 200) {
    List<dynamic> myList = List.filled(10, 0, growable: false);
    var numberOfArtists = 10;
    // If the server did return a 200 CREATED response,
    final artists_info = convert.jsonDecode(getUserTopArtistResponse.body)
        as Map<String, dynamic>;
    for (int i = 0; i < numberOfArtists; i++) {
      myList[i] = artists.topOfArtists.fromJson(artists_info["items"][i]);
    }
    return myList;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getUserTopArtistResponse.statusCode;
    throw Exception(
        'Failed to get Arists USER response. Status code = $statusCode');
  }
}

//ТОП 10 tracks
Future<List<dynamic>> getUserTopSongs(dynamic token) async {
  final Map<String, String> getUserSongBody = {
    'time_range': 'short_term',
    'limit': '10',
    'offset': '0',
  };

  final Map<String, String> getUserSongHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  final Response getUserTopSongsResponse = await http.get(
      Uri.https('api.spotify.com', '/v1/me/top/tracks', getUserSongBody),
      headers: getUserSongHeaders);

  if (getUserTopSongsResponse.statusCode == 200) {
    List<dynamic> newList = List.filled(10, 0, growable: false);
    var numberOfSongs = 10;
    // If the server did return a 200 CREATED response,
    final tracks_info = convert.jsonDecode(getUserTopSongsResponse.body)
        as Map<String, dynamic>;
    for (int i = 0; i < numberOfSongs; i++) {
      newList[i] = songs.topOfSongs.fromJson(tracks_info["items"][i]);
    }
    return newList;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getUserTopSongsResponse.statusCode;
    throw Exception(
        'Failed to get tracks USER response. Status code = $statusCode');
  }
}


//Top 10
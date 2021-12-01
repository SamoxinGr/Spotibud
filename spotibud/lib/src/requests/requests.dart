import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spotibud/src/utils/secure_storage.dart';
import 'package:spotibud/src/models/top_of_artists.dart';
import 'package:spotibud/src/models/top_of_songs.dart';
import 'package:spotibud/src/models/followed_artists.dart';
import 'package:spotibud/src/auth.dart' as auth;
import 'package:spotibud/src/models/user_info.dart';

String redirect_uri = "https://samoxingr.github.io/Naughty-code/index.html";

Future<Map<String, dynamic>> getTokenAsOwner(String? code) async {
  final Map<String, String> tokenBody = {
    "grant_type": "authorization_code",
    "client_id": auth.client_id,
    "client_secret": auth.client_secret,
    "code": "$code",
    "redirect_uri": 'https://samoxingr.github.io/Naughty-code/index.html'
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
    "redirect_uri": 'https://samoxingr.github.io/Naughty-code/index.html'
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
Future<List<UserInfo>> getUser(String? token) async {
  final Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": "Bearer $token",
  };
  final Response getUserResponse =
      await http.get(Uri.https("api.spotify.com", "/v1/me"), headers: headers);
  if (getUserResponse.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    List<UserInfo> userList = List.empty(growable: true);
    var user_info = await convert.jsonDecode(getUserResponse.body);
    userList.add(UserInfo.fromJson(user_info));
    return userList;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getUserResponse.statusCode;
    throw Exception('Failed to get USER response. Status code = $statusCode');
  }
}

//REFRESH TOKEN
Future<Map<String, dynamic>> refreshToken(String? refreshToken) async {
  final Map<String, String> refreshTokenBody = {
    "grant_type": "refresh_token",
    "client_id": auth.client_id,
    "client_secret": auth.client_secret,
    "refresh_token": "${refreshToken}",
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
Future<List<topOfArtists>> getUserTopArtists(String? token, String term) async {
  //getUser(token);
  final Map<String, String> getUserArtistbody = {
    'time_range': '$term',
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

  if (getUserTopArtistResponse.statusCode == 200) {
    List<topOfArtists> myList = List.empty(growable: true);
    int numberOfArtists = 10;
    // If the server did return a 200 CREATED response,
    var artists_info = convert.jsonDecode(getUserTopArtistResponse.body);
    for (int i = 0; i < numberOfArtists; i++) {
      myList.add(topOfArtists.fromJson(artists_info["items"][i]));
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
Future<List<topOfSongs>> getUserTopSongs(String? token, String term) async {
  final Map<String, String> getUserSongBody = {
    'time_range': '$term',
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
    List<topOfSongs> newList = List.empty(growable: true);
    var numberOfSongs = 10;
    // If the server did return a 200 CREATED response,
    var tracks_info = convert.jsonDecode(getUserTopSongsResponse.body);
    for (int i = 0; i < numberOfSongs; i++) {
      newList.add(topOfSongs.fromJson(tracks_info["items"][i]));
    }
    return newList;
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getUserTopSongsResponse.statusCode;
    throw Exception(
        'Failed to get tracks USER response. Status code = $statusCode');
  }
}

//followed artists
Future<List<lastNews>> getFollowedArtists(String? token) async {
  final Map<String, String> getFollowedArtistsbody = {
    'type': 'artist',
    'limit': '50',
  };

  final Map<String, String> getFollowedArtistsHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  final Response getFollowedArtistsResponse = await http.get(
      Uri.https('api.spotify.com', '/v1/me/following', getFollowedArtistsbody),
      headers: getFollowedArtistsHeaders);

  if (getFollowedArtistsResponse.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    var FollowedArtists_info =
        convert.jsonDecode(getFollowedArtistsResponse.body);
    List<String> idList = List.empty(growable: true);
    var numberOfArtists = FollowedArtists_info['artists']['total'] as int;
    if (numberOfArtists > 50) numberOfArtists = 50;
    for (int i = 0; i < numberOfArtists; i++) {
      idList.add(FollowedArtists_info['artists']['items'][i]['id']);
    }
    return getArtistLastRelease(token, idList);
  } else {
    // If the server did not return a 200 CREATED response,
    var statusCode = getFollowedArtistsResponse.statusCode;
    throw Exception(
        'Failed to get Arists USER response. Status code = $statusCode');
  }
}

//Last releases
Future<List<lastNews>> getArtistLastRelease(
    String? token, List<String> idList) async {
  List<lastNews> newList = [];
  for (int i = 0; i < idList.length; i++) {
    final Map<String, String> getArtistSingleBody = {
      'include_groups': 'single',
      'limit': '1',
      'market': 'RU',
    };

    final Map<String, String> getArtistAlbumBody = {
      'include_groups': 'album',
      'limit': '1',
      'market': 'RU',
    };

    final Map<String, String> getArtistSingleHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final Map<String, String> getArtistAlbumHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final Response getArtistSingleResponse = await http.get(
        Uri.https('api.spotify.com', '/v1/artists/${idList[i]}/albums',
            getArtistSingleBody),
        headers: getArtistSingleHeaders);
    var lastSingle_info = convert.jsonDecode(getArtistSingleResponse.body);

    final Response getArtistAlbumResponse = await http.get(
        Uri.https('api.spotify.com', '/v1/artists/${idList[i]}/albums',
            getArtistAlbumBody),
        headers: getArtistAlbumHeaders);
    var lastAlbum_info = convert.jsonDecode(getArtistAlbumResponse.body);

    if (getArtistSingleResponse.statusCode == 200 ||
        getArtistAlbumResponse.statusCode == 200) {
      var single = DateTime.parse(lastSingle_info['items'][0]['release_date']);
      var album = DateTime.now();
      if ((lastAlbum_info['total'] as int) != 0) {
        album = DateTime.parse(lastAlbum_info['items'][0]['release_date']);
      } else {
        album = DateTime.utc(1900, 1, 1);
      }
      if (single.isAfter(album) == true) {
        newList.add(lastNews.fromJson(lastSingle_info['items'][0]));
      } else {
        newList.add(lastNews.fromJson(lastAlbum_info['items'][0]));
      }
    } else {
      // If the server did not return a 200 CREATED response,
      var statusCode = getArtistSingleResponse.statusCode;
      throw Exception(
          'Failed to get tracks USER response. Status code = $statusCode');
    }
  }
  return newList;
}

//Best artist
Future<List<topOfArtists>> getUserArtist(String? token) async {
  final Map<String, String> getUserArtistbody = {
    'time_range': 'long_term',
    'limit': '1',
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
  print(getUserTopArtistResponse.statusCode);
  var artists_info = convert.jsonDecode(getUserTopArtistResponse.body);
  List<topOfArtists> artistList = List.empty(growable: true);
  artistList.add(topOfArtists.fromJson(artists_info['items'][0]));
  return artistList;
}

//Best song
Future<List<topOfSongs>> getUserSong(String? token) async {
  final Map<String, String> getUserSongBody = {
    'time_range': 'long_term',
    'limit': '1',
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
  var songs_info = convert.jsonDecode(getUserTopSongsResponse.body);
  print(getUserTopSongsResponse.statusCode);
  List<topOfSongs> songList = List.empty(growable: true);
  songList.add(topOfSongs.fromJson(songs_info['items'][0]));
  return songList;
}

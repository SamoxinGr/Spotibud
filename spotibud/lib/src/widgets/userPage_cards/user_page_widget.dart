import 'package:flutter/material.dart';
import 'package:spotibud/src/models/top_of_artists.dart';
import 'package:spotibud/src/models/top_of_songs.dart';
import 'package:spotibud/src/pages/cubit/userPage/user_page_cubit.dart';
import 'package:spotibud/src/models/user_info.dart';

Widget UserInfoWidget(UserInfo item, topOfArtists artists, topOfSongs songs,
    BuildContext context, UserLoadedState state) {
  final double height = MediaQuery.of(context).size.height;
  return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.all(10),
      elevation: 7,
      shadowColor: Colors.grey[700],
      child: SizedBox(
        height: height / 2,
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${item.image}'),
            ),
            Text(
              '${item.name}',
              style: TextStyle(
                  fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
            ),
            Text(
              '${item.country}',
              style: TextStyle(
                  fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
            ),
            Text(
              'Artist - ${artists.name}',
              style: TextStyle(
                  fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
            ),
            Text(
              'Song - ${songs.name} (${artists.name})',
              style: TextStyle(
                  fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
            ),
          ],
        ),
      ));
}

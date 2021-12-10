import 'package:flutter/material.dart';
import 'package:spotibud/src/models/top_of_artists.dart';
import 'package:spotibud/src/models/top_of_songs.dart';
import 'package:spotibud/src/pages/cubit/userPage/user_page_cubit.dart';
import 'package:spotibud/src/models/user_info.dart';

Widget UserInfoWidget(UserInfo item, topOfArtists artists, topOfSongs songs,
    BuildContext context, UserLoadedState state) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;
  return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.all(10),
      elevation: 7,
      shadowColor: Colors.grey[700],
      child: SizedBox(
        height: height / 1.25,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
              child: CircleAvatar(
                backgroundImage: NetworkImage('${item.image}'),
                radius: height / 13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${item.name}',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white70,
                    fontSize: width / 15),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Your favourite artist:',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white70,
                        fontSize: width / 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    '${artists.name}',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white70,
                        fontSize: width / 20),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: CircleAvatar(
                  backgroundImage: NetworkImage('${artists.images}'),
                  radius: height / 15),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 5),
              child: Text(
                'Your favorite song: ',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white70,
                    fontSize: width / 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 18),
              child: Text(
                '"${songs.name}" by ${songs.author}',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white70,
                    fontSize: width / 20),
              ),
            ),
            Image(
              image: NetworkImage('${songs.images}', scale: height / 132),
            ),
          ],
        ),
      ));
}

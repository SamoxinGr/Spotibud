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
        height: height / 1.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
              child: CircleAvatar(
                backgroundImage: NetworkImage('${item.image}'),
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${item.name}',
                style: TextStyle(
                    fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
              ),
            ),
             Row(
               children: [
                 Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Your favourite Artist:',
                      style: TextStyle(
                          fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
                    ),
                  ),
                 Text('${artists.name}',
                 style: TextStyle(
                 fontFamily: 'Inter', color: Colors.white70, fontSize: 20),
                 ),
               ],
             ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: CircleAvatar(backgroundImage: NetworkImage('${artists.images}'), radius: 40
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 5),
              child: Text('Your favorite song: ', style: TextStyle(
                  fontFamily: 'Inter', color: Colors.white70, fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
              child: Text('${songs.name} by ${songs.author}', style: TextStyle(
                  fontFamily: 'Inter', color: Colors.white70, fontSize: 20),),
            ),
            CircleAvatar(backgroundImage: NetworkImage('${songs.images}'), radius: 40
            ),

          ],
        ),
      ));
}



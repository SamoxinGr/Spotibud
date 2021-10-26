import 'package:flutter/material.dart';
import 'package:spotibud/pages/cubit/topOfSongs/topOfSongs_cubit.dart';
import 'package:spotibud/src/objects/topOfSongs.dart';

Widget topOfSongsWidget(
topOfSongs item, BuildContext context, topOfSongsLoadedState state){
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 20,
    shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    shadowColor: Colors.green[100],
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            "${item.author}",
            style: TextStyle(
              fontSize: 25,

            ),
          ),
          subtitle: Text("${item.name}", style: TextStyle(
            color: Colors.black,
            fontFamily:"Merriweather",
            fontWeight:FontWeight.bold,
          ),),
        ),
      ],
    ),
  );
}


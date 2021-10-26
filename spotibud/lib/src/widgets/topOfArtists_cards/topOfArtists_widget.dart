import 'package:flutter/material.dart';
import 'package:spotibud/pages/cubit/topOfArtists/topOfArtists_cubit.dart';
import 'package:spotibud/src/objects/topOfArtists.dart';

Widget topOfArtistsWidget(
    topOfArtists item, BuildContext context, topOfArtistsLoadedState state) {
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
          leading: CircleAvatar(
              radius: 35, backgroundImage: NetworkImage(item.images)),
          title: Text(
            "${item.name}",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          subtitle: Text(
            "${item.genres}",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Merriweather",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}


/*
  return Card(
      color: Colors.green,
      elevation: 10.0,
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 8, left: 8, right: 8),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${item.genres[0]}".substring(0, 10),
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Exo 2'))
          ]),
          const SizedBox(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 350.0,
              height: 80.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${item.images}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
          ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text("${item.name}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Exo 2')),
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text("${item.name}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Exo 2')),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text("${item.type}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Exo 2')),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ]),
      ));
}
*/
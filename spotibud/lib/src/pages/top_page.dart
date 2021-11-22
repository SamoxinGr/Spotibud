import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spotibud/src/models/top_of_songs.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/topOfSongs_cards/top_of_songs_widget.dart';
import 'dart:convert' as convert;

import '../pages/cubit/topOfSongs/top_of_songs_cubit.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopOfSongsCubit(),
      child: const _TopSongsPage(),
    );
  }

  /*@override
  Widget getSongs(BuildContext context){
    return BlocProvider(create: (_) => topOfSongsCubit(),
      child: const _TopSongsPage(),
    );
  }*/
}

class _TopSongsPage extends StatelessWidget {
  const _TopSongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String term = 'short_term';

    return BlocBuilder<TopOfSongsCubit, TopOfSongsState>(
        builder: (context, state) {
      if (state is TopOfSongsInitial) {
        context.read<TopOfSongsCubit>().informInitial();
        context.read<TopOfSongsCubit>().loadtopOfSongs(term);
        return Scaffold(
          backgroundColor: Colors.black,
          body: const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.amber),
          ),
        );
      }

      if (state is TopOfSongsLoadedState) {
        return RefreshIndicator(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: getAppBar(context),
            body: getBody(state),
          ),
          backgroundColor: Colors.black87,
          onRefresh: () => context.read<TopOfSongsCubit>().reloadtopOfSongs(),
        );
      }
      return Container();
    });
  }

  PreferredSizeWidget getAppBar(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    String term = 'short_term';
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: height / 10,
      title: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 40,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton(
                tooltip: "Options",
                elevation: 25,
                icon: Icon(Icons.more_horiz),
                color: Colors.grey[850],
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade900,
                      width: 1,
                    )
                ),
                itemBuilder: (_) => const<PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      child: Text('All time', style: TextStyle(color: Colors.white60, fontFamily: "Inter"),), value: 'long_term'),
                  PopupMenuItem<String>(
                      child: Text('Half-year', style: TextStyle(color: Colors.white60, fontFamily: "Inter")), value: 'medium_term'),
                  PopupMenuItem<String>(
                      child: Text('Last month', style: TextStyle(color: Colors.white60, fontFamily: "Inter")), value: 'short_term'),
                ],
                onSelected: (value) {
                  term = value as String;
                  context.read<TopOfSongsCubit>().loadtopOfSongs(term);
                }),
            //Сделать кнопку,вы зывающую виджет с выбором параметров запроса
          ],
        ),
      ),
    );
  }

  Widget getBody(state) {
    //var screenHeight = MediaQuery.of().size.height;
    //var screenWidth = MediaQuery.of().size.width;
    return ListView.builder(
      itemCount: state.topOfSongsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              launchUniversalLink(state.topOfSongsList[index].external_urls),
          child: TopOfSongsWidget(state.topOfSongsList[index], context, state),
        );
      },
    );
  }
}

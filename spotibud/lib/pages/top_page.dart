import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spotibud/src/objects/topOfSongs.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/topOfSongs/topOfSongs_widget.dart';
import 'dart:convert' as convert;


import '../pages/cubit/topOfSongs/topOfSongs_cubit.dart';


class SongsPage extends StatelessWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => topOfSongsCubit(),
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
    return BlocBuilder<topOfSongsCubit, TopOfSongsState>(
        builder: (context, state) {
          if (state is topOfSongsInitial) {
            context.read<topOfSongsCubit>().informInitial();
            context
                .read<topOfSongsCubit>()
                .loadtopOfSongs();
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.amber),
            );
          }

          if (state is topOfSongsLoadedState) {
            return RefreshIndicator(
              child: Scaffold(
                appBar: getAppBar(),
                body: getBody(state),
              ),
              backgroundColor: Colors.blue,
              onRefresh: () =>
                  context.read<topOfSongsCubit>().reloadtopOfSongs(),
            );
          }
          return Container();
        });
  }


  PreferredSizeWidget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons
                .list)
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
          onTap: () => launchUniversalLink(state.topOfSongsList[index].uri),
          child:
          topOfSongsWidget(state.topOfSongsList[index], context, state),
        );
      },
    );
  }}
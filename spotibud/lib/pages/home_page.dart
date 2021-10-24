import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotibud/src/objects/topOfArtists.dart';
import 'dart:convert' as convert;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotibud/src/objects/topOfArtists.dart';
import 'package:spotibud/pages/cubit/topOfArtists_cubit.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/pages/loading_page.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/topOfArtists_cards/topOfArtists_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
//  _HomePageState createState() => _HomePageState();
//}
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => topOfArtistsCubit(),
      child: const _HomePageState(),
    );
  }
}

//class _HomePageState extends State<HomePage> {
class _HomePageState extends StatelessWidget {
  const _HomePageState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<topOfArtistsCubit, topOfArtistsState>(
        builder: (context, state) {
      if (state is topOfArtistsInitial) {
        context.read<topOfArtistsCubit>().informInitial();
        context
            .read<topOfArtistsCubit>()
            .loadtopOfArtists(); // run Circular progress bar while news is loading
        return const Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber),
        );
      }
      /*if (state is NewsErrorState) {
        // Throw error if state is NewsError
        return ErrorPage(exceptionPageName: LastNewsPage()); ПОКА без этого
      }*/
      if (state is topOfArtistsLoadedState) {
        // Reload News if state is NewsReload (wheel page down)
        return RefreshIndicator(
          child: Scaffold(
            appBar: getAppBar(),
            body: getBody(state),
          ),
          backgroundColor: Colors.blue,
          onRefresh: () =>
              context.read<topOfArtistsCubit>().reloadtopOfArtists(),
        );
      }
      return Container();
    });
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[850],
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
                .list) //Сделать кнопку,вы зывающую виджет с выбором параметров запроса
          ],
        ),
      ),
    );
  }

  Widget getBody(state) {
    //var screenHeight = MediaQuery.of().size.height;
    //var screenWidth = MediaQuery.of().size.width;
    return ListView.builder(
      itemCount: state.topOfArtistsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => launchUniversalLink(state.topOfArtistsList[index].uri),
          child:
              topOfArtistsWidget(state.topOfArtistsList[index], context, state),
        );
      },
    );
  }
}

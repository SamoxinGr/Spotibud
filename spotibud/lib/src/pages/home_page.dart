import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotibud/src/pages/cubit/topOfArtists/topOfArtists_cubit.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/topOfArtists_cards/topOfArtists_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => topOfArtistsCubit(),
      child: const _HomePageState(),
    );
  }
}

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

      if (state is topOfArtistsLoadedState) {
        return RefreshIndicator(
          child: Scaffold(
            appBar: getAppBar(),
            body: getBody(state),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black87,
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
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
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
            Icon(Icons.list)
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
      itemCount: state.topOfArtistsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              launchUniversalLink(state.topOfArtistsList[index].external_urls),
          child:
              topOfArtistsWidget(state.topOfArtistsList[index], context, state),
        );
      },
    );
  }
}
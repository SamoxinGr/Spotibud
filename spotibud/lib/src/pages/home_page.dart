import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotibud/src/pages/cubit/topOfArtists/top_of_artists_cubit.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/topOfArtists_cards/top_of_artists_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopOfArtistsCubit(),
      child: const _HomePageState(),
    );
  }
}

class _HomePageState extends StatelessWidget {
  const _HomePageState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopOfArtistsCubit, TopOfArtistsState>(
        builder: (context, state) {
      if (state is TopOfArtistsInitial) {
        String term = 'short_term';
        context.read<TopOfArtistsCubit>().informInitial();
        context.read<TopOfArtistsCubit>().loadtopOfArtists(
            term); // run Circular progress bar while news is loading
        return const Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber),
        );
      }

      if (state is TopOfArtistsLoadedState) {
        return RefreshIndicator(
          child: Scaffold(
            appBar: GetAppBar(context),
            body: GetBody(state),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black87,
          onRefresh: () =>
              context.read<TopOfArtistsCubit>().reloadtopOfArtists(),
        );
      }
      return Container();
    });
  }

  PreferredSizeWidget GetAppBar(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    String term = 'short_term';
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: height / 10,
      title: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 40,
        ),
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
                )),
                itemBuilder: (_) => const <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                          child: Text(
                            'All time',
                            style: TextStyle(
                                color: Colors.white60, fontFamily: "Inter"),
                          ),
                          value: 'long_term'),
                      PopupMenuItem<String>(
                          child: Text('Half-year',
                              style: TextStyle(
                                  color: Colors.white60, fontFamily: "Inter")),
                          value: 'medium_term'),
                      PopupMenuItem<String>(
                          child: Text('Last month',
                              style: TextStyle(
                                  color: Colors.white60, fontFamily: "Inter")),
                          value: 'short_term'),
                    ],
                onSelected: (value) {
                  term = value as String;
                  context.read<TopOfArtistsCubit>().loadtopOfArtists(term);
                }),
          ],
        ),
      ),
    );
  }

  Widget GetBody(state) {
    return ListView.builder(
      itemCount: state.topOfArtistsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              launchUniversalLink(state.topOfArtistsList[index].external_urls),
          child:
              TopOfArtistsWidget(state.topOfArtistsList[index], context, state),
        );
      },
    );
  }
}

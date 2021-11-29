import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/lastNews_cards/last_news_widget.dart';

import '../pages/cubit/lastNews/last_news_cubit.dart';

class LastNewsPage extends StatelessWidget {
  const LastNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LastNewsCubit(),
      child: const _LastNewsState(),
    );
  }
}

class _LastNewsState extends StatelessWidget {
  const _LastNewsState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastNewsCubit, LastNewsState>(builder: (context, state) {
      if (state is LastNewsInitial) {
        context.read<LastNewsCubit>().informInitial();
        context
            .read<LastNewsCubit>()
            .loadlastNews(); // run Circular progress bar while news is loading
        return Scaffold(
          backgroundColor: Colors.black,
          body: const Center(
            child:
                CircularProgressIndicator(backgroundColor: Colors.greenAccent),
          ),
        );
      }

      if (state is LastNewsLoadedState) {
        return RefreshIndicator(
          child: Scaffold(
            appBar: GetAppBar(context),
            body: GetBody(state),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black87,
          onRefresh: () => context.read<LastNewsCubit>().reloadlastNews(),
        );
      }
      return Container();
    });
  }

  PreferredSizeWidget GetAppBar(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      toolbarHeight: height / 14,
      title: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      ),
    );
  }

  Widget GetBody(state) {
    return ListView.builder(
      itemCount: state.lastNewsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              launchUniversalLink(state.lastNewsList[index].external_urls),
          child: LastNewsWidget(state.lastNewsList[index], context, state),
        );
      },
    );
  }
}

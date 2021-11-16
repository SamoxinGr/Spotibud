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
        return const Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber),
        );
      }

      if (state is LastNewsLoadedState) {
        return RefreshIndicator(
          child: Scaffold(
            appBar: GetAppBar(),
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

  PreferredSizeWidget GetAppBar() {
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

  Widget GetBody(state) {
    //var screenHeight = MediaQuery.of().size.height;
    //var screenWidth = MediaQuery.of().size.width;
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

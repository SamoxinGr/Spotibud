import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotibud/src/utils/url_launch.dart';
import 'package:spotibud/src/widgets/lastNews_cards/lastNews_widget.dart';

import '../pages/cubit/lastNews/lastNews_cubit.dart';

class LastNewsPage extends StatelessWidget {
  const LastNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => lastNewsCubit(),
      child: const _LastNewsState(),
    );
  }
}

class _LastNewsState extends StatelessWidget {
  const _LastNewsState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<lastNewsCubit, lastNewsState>(builder: (context, state) {
      if (state is lastNewsInitial) {
        context.read<lastNewsCubit>().informInitial();
        context
            .read<lastNewsCubit>()
            .loadlastNews(); // run Circular progress bar while news is loading
        return const Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber),
        );
      }

      if (state is lastNewsLoadedState) {
        return RefreshIndicator(
          child: Scaffold(
            appBar: getAppBar(),
            body: getBody(state),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black87,
          onRefresh: () => context.read<lastNewsCubit>().reloadlastNews(),
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
      itemCount: state.lastNewsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              launchUniversalLink(state.lastNewsList[index].external_urls),
          child: lastNewsWidget(state.lastNewsList[index], context, state),
        );
      },
    );
  }
}

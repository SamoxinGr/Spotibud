part of 'last_news_cubit.dart';

@immutable
abstract class LastNewsState {} // abstract states class

class LastNewsInitial extends LastNewsState {}

class LastNewsLoadedState extends LastNewsState {
  final List<lastNews> lastNewsList;

  LastNewsLoadedState(this.lastNewsList);
}

class LastNewsErrorState extends LastNewsState {
  final String errorMessage;

  LastNewsErrorState(this.errorMessage);
}

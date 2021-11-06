part of 'lastNews_cubit.dart';

@immutable
abstract class lastNewsState {} // abstract states class

class lastNewsInitial extends lastNewsState {}

class lastNewsLoadedState extends lastNewsState {
  final List lastNewsList;

  lastNewsLoadedState(this.lastNewsList);
}

class lastNewsErrorState extends lastNewsState {
  final String errorMessage;

  lastNewsErrorState(this.errorMessage);
}

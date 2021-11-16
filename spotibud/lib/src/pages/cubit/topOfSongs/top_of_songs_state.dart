part of 'top_of_songs_cubit.dart';

@immutable
abstract class TopOfSongsState {} // abstract states class

class TopOfSongsInitial extends TopOfSongsState {}

class TopOfSongsLoadedState extends TopOfSongsState {
  final List topOfSongsList;

  TopOfSongsLoadedState(this.topOfSongsList);
}

class TopOfSongsErrorState extends TopOfSongsState {
  final String errorMessage;

  TopOfSongsErrorState(this.errorMessage);
}

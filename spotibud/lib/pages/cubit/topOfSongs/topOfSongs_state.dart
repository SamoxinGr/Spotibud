part of 'topOfSongs_cubit.dart';

@immutable
abstract class TopOfSongsState {} // abstract states class

class topOfSongsInitial extends TopOfSongsState {}

class topOfSongsLoadedState extends TopOfSongsState {
  final List topOfSongsList;

  topOfSongsLoadedState(this.topOfSongsList);
}

class topOfSongsErrorState extends TopOfSongsState {
  final String errorMessage;

  topOfSongsErrorState(this.errorMessage);


}
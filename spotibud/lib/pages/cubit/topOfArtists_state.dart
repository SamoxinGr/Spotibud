part of 'topOfArtists_cubit.dart';

@immutable
abstract class topOfArtistsState {} // abstract states class

class topOfArtistsInitial extends topOfArtistsState {}

class topOfArtistsLoadedState extends topOfArtistsState {
  final List topOfArtistsList;

  topOfArtistsLoadedState(this.topOfArtistsList);
}

class topOfArtistsErrorState extends topOfArtistsState {
  final String errorMessage;

  topOfArtistsErrorState(this.errorMessage);
}

part of 'top_of_artists_cubit.dart';

@immutable
abstract class TopOfArtistsState {} // abstract states class

class TopOfArtistsInitial extends TopOfArtistsState {}

class TopOfArtistsLoadedState extends TopOfArtistsState {
  final List<topOfArtists> topOfArtistsList;

  TopOfArtistsLoadedState(this.topOfArtistsList);
}

class TopOfArtistsErrorState extends TopOfArtistsState {
  final String errorMessage;

  TopOfArtistsErrorState(this.errorMessage);
}

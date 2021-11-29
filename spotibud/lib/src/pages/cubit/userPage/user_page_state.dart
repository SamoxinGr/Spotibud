part of 'user_page_cubit.dart';

@immutable
abstract class UserState {} // abstract states class

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final List<UserInfo> userList;
  final List<topOfArtists> artistList;
  final List<topOfSongs> songList;

  UserLoadedState(this.userList, this.artistList, this.songList);
}

class UserErrorState extends UserState {
  final String errorMessage;

  UserErrorState(this.errorMessage);
}

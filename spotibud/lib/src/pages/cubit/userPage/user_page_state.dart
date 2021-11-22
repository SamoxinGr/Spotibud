part of 'user_page_cubit.dart';

@immutable
abstract class UserState {} // abstract states class

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final List UserList;

  UserLoadedState(this.UserList);
}

class UserErrorState extends UserState {
  final String errorMessage;

  UserErrorState(this.errorMessage);
}

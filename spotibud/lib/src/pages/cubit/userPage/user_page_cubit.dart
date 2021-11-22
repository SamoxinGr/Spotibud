import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

part 'user_page_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> informInitial() async {
    print('UserPage loading');
  }

  Future<void> loadUser() async {
    try {
      emit(UserLoadedState(await getUser((await UserSecureStorage
          .getTokenFromStorage())!))); // request top songs
      print('User loaded');
    } catch (e) {
      emit(UserErrorState('Failed User Load'));
    }
  }

  Future<void> reloadUser() async {
    emit(UserInitial());
  }
}

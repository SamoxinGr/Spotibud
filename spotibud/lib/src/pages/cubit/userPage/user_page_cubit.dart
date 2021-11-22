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
    try {// request top songs
      final user_info = await getUser(await UserSecureStorage
          .getTokenFromStorage());
      final artist = await getUserArtist((await UserSecureStorage.getTokenFromStorage()));
      final song = await getUserSong((await UserSecureStorage.getTokenFromStorage()));
      print(user_info);
      print(artist);
      print(song);
      print('User loaded');
    emit(UserLoadedState(user_info, artist, song));

    } catch (e) {
      emit(UserErrorState('Failed User Load'));
    }
  }

  Future<void> reloadUser() async {
    emit(UserInitial());
  }
}

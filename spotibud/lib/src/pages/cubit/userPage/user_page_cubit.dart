import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';
import 'package:spotibud/src/models/user_info.dart';
import 'package:spotibud/src/models/top_of_artists.dart';
import 'package:spotibud/src/models/top_of_songs.dart';

part 'user_page_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> informInitial() async {
    print('UserPage loading');
  }

  Future<void> loadUser() async {
    try {
      final user_info =
          await getUser(await UserSecureStorage.getTokenFromStorage());
      final artist =
          await getUserArtist((await UserSecureStorage.getTokenFromStorage()));
      final song =
          await getUserSong((await UserSecureStorage.getTokenFromStorage()));
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

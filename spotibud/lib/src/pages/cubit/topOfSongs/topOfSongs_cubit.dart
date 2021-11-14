import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

part 'topOfSongs_state.dart';

class topOfSongsCubit extends Cubit<TopOfSongsState> {
  topOfSongsCubit() : super(topOfSongsInitial());

  Future<void> informInitial() async {
    print('topOfSongsPage loading');
  }

  Future<void> loadtopOfSongs(String term) async {
    try {
      emit(topOfSongsLoadedState(await getUserTopSongs((await UserSecureStorage
          .getTokenFromStorage())!, term))); // request top songs
      print('Top loaded');
    } catch (e) {
      emit(topOfSongsErrorState('Failed Top Load'));
    }
  }

  Future<void> reloadtopOfSongs() async {
    emit(topOfSongsInitial());
  }
}

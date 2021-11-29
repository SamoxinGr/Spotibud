import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';
import 'package:spotibud/src/models/top_of_songs.dart';

part 'top_of_songs_state.dart';

class TopOfSongsCubit extends Cubit<TopOfSongsState> {
  TopOfSongsCubit() : super(TopOfSongsInitial());

  Future<void> informInitial() async {
    print('topOfSongsPage loading');
  }

  Future<void> loadtopOfSongs(String term) async {
    try {
      emit(TopOfSongsLoadedState(await getUserTopSongs(
          (await UserSecureStorage.getTokenFromStorage())!,
          term))); // request top songs
      print('Top loaded');
    } catch (e) {
      emit(TopOfSongsErrorState('Failed Top Load'));
    }
  }

  Future<void> reloadtopOfSongs() async {
    emit(TopOfSongsInitial());
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/pages/loading_page.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

part 'topOfArtists_state.dart';

class topOfArtistsCubit extends Cubit<topOfArtistsState> {
  topOfArtistsCubit() : super(topOfArtistsInitial());

  Future<void> informInitial() async {
    print('topOfArtistPage loading');
  }

  Future<void> loadtopOfArtists(String term) async {
    try {
      emit(topOfArtistsLoadedState(await getUserTopArtists(
          (await UserSecureStorage
              .getTokenFromStorage())!, term))); // request top artists
      print('Top loaded');
    } catch (e) {
      emit(topOfArtistsErrorState('Failed Top Load'));
    }
  }

  Future<void> reloadtopOfArtists() async {
    emit(topOfArtistsInitial());
  }
}

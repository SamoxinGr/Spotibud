import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/pages/loading_page.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

part 'top_of_artists_state.dart';

class TopOfArtistsCubit extends Cubit<TopOfArtistsState> {
  TopOfArtistsCubit() : super(TopOfArtistsInitial());

  Future<void> informInitial() async {
    print('topOfArtistPage loading');
  }

  Future<void> loadtopOfArtists(String term) async {
    try {
      emit(TopOfArtistsLoadedState(await getUserTopArtists(
          (await UserSecureStorage
              .getTokenFromStorage())!, term))); // request top artists
      print('Top loaded');
    } catch (e) {
      emit(TopOfArtistsErrorState('Failed Top Load'));
    }
  }

  Future<void> reloadtopOfArtists() async {
    emit(TopOfArtistsInitial());
  }
}

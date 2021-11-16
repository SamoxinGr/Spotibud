import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

part 'last_news_state.dart';

class LastNewsCubit extends Cubit<LastNewsState> {
  LastNewsCubit() : super(LastNewsInitial());

  Future<void> informInitial() async {
    print('lastNewsPage loading');
  }

  Future<void> loadlastNews() async {
    try {
      emit(LastNewsLoadedState(await getFollowedArtists((await UserSecureStorage
          .getTokenFromStorage())!))); // request top songs
      print('Top loaded');
    } catch (e) {
      emit(LastNewsErrorState('Failed Top Load'));
    }
  }

  Future<void> reloadlastNews() async {
    emit(LastNewsInitial());
  }
}

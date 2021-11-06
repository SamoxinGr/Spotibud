import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotibud/src/requests/requests.dart';
import 'package:spotibud/src/utils/secure_storage.dart';

part 'lastNews_state.dart';

class lastNewsCubit extends Cubit<lastNewsState> {
  lastNewsCubit() : super(lastNewsInitial());

  Future<void> informInitial() async {
    print('lastNewsPage loading');
  }

  Future<void> loadlastNews() async {
    try {
      emit(lastNewsLoadedState(await getFollowedArtists((await UserSecureStorage
          .getTokenFromStorage())!))); // request top songs
      print('Top loaded');
    } catch (e) {
      emit(lastNewsErrorState('Failed Top Load'));
    }
  }

  Future<void> reloadlastNews() async {
    emit(lastNewsInitial());
  }
}

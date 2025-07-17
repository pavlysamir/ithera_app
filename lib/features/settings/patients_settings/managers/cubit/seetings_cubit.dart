import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:meta/meta.dart';

part 'seetings_state.dart';

class SettingsCubit extends Cubit<SeetingsState> {
  SettingsCubit() : super(SeetingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  lgOut() async {
    await CacheHelper.delete(
      key: CacheConstants.userId,
    );
    await CacheHelper.deleteSecureData(key: CacheConstants.token);
    ();
    emit(SignOutSuccess());
  }
}

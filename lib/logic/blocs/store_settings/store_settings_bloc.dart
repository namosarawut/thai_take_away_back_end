import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/data/model/store_settings_model.dart';
import 'package:thai_take_away_back_end/repositores/store_settings_repository.dart';

part 'store_settings_event.dart';

part 'store_settings_state.dart';

// logic/blocs/store_settings/store_settings_bloc.dart

class StoreSettingsBloc extends Bloc<StoreSettingsEvent, StoreSettingsState> {
  final StoreSettingsRepository repository;

  StoreSettingsBloc(this.repository) : super(StoreSettingsInitial()) {
    on<FetchStoreSettings>((event, emit) async {
      emit(StoreSettingsLoading());
      try {
        final settings = await repository.getStoreSettings();
        emit(StoreSettingsLoaded(settings));
      } catch (e) {
        emit(StoreSettingsError(e.toString()));
      }
    });
    on<UpdateStoreSettings>((e, emit) async {
      emit(StoreSettingsLoading());
      try {
        final msg = await repository.updateStoreSettings(e.settings);
        // หลัง update สำเร็จ ส่ง success
        emit(StoreSettingsUpdateSuccess(msg));
        // แล้วดึงค่าล่าสุดกลับมา
        final fresh = await repository.getStoreSettings();
        emit(StoreSettingsLoaded(fresh));
      } catch (e) {
        emit(StoreSettingsError(e.toString()));
      }
    });
  }
}

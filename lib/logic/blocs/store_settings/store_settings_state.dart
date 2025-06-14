part of 'store_settings_bloc.dart';


@immutable
abstract class StoreSettingsState {}

class StoreSettingsInitial extends StoreSettingsState {}

class StoreSettingsLoading extends StoreSettingsState {}

class StoreSettingsLoaded extends StoreSettingsState {
  final StoreSettingsModel settings;
  StoreSettingsLoaded(this.settings);
}

class StoreSettingsError extends StoreSettingsState {
  final String message;
  StoreSettingsError(this.message);
}

/// สำหรับสถานะหลัง Update สำเร็จ
class StoreSettingsUpdateSuccess extends StoreSettingsState {
  final String message;
  StoreSettingsUpdateSuccess(this.message);
}


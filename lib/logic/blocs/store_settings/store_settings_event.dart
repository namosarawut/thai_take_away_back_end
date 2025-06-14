part of 'store_settings_bloc.dart';

@immutable
abstract class StoreSettingsEvent {}

/// เริ่มดึงค่าการตั้งค่าร้าน
class FetchStoreSettings extends StoreSettingsEvent {}

/// บันทึกค่าการตั้งค่าร้านที่ปรับแล้ว
class UpdateStoreSettings extends StoreSettingsEvent {
  final StoreSettingsModel settings;
  UpdateStoreSettings(this.settings);
}

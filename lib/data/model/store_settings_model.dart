// data/model/store_settings_model.dart

class StoreSettingsModel {
  final double latitude;
  final double longitude;
  final int serviceRadius;

  StoreSettingsModel({
    required this.latitude,
    required this.longitude,
    required this.serviceRadius,
  });

  factory StoreSettingsModel.fromJson(Map<String, dynamic> json) {
    return StoreSettingsModel(
      latitude: double.parse(json['latitude'] as String),
      longitude: double.parse(json['longitude'] as String),
      serviceRadius: json['serviceRadius'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),
    'serviceRadius': serviceRadius,
  };
}

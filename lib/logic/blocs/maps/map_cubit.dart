// map_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class MapState {
  final double distanceKm;
  final LatLng center;

  MapState({required this.distanceKm, required this.center});

  MapState copyWith({double? distanceKm, LatLng? center}) {
    return MapState(
      distanceKm: distanceKm ?? this.distanceKm,
      center: center ?? this.center,
    );
  }
}

class MapCubit extends Cubit<MapState> {
  MapCubit()
      : super(MapState(
    distanceKm: 5,
    center: LatLng(13.736717, 100.523186), // default Bangkok
  ));

  void distanceChanged(double km) {
    emit(state.copyWith(distanceKm: km));
  }

  void centerChanged(LatLng newCenter) {
    emit(state.copyWith(center: newCenter));
  }
}

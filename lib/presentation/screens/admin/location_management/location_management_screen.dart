// map_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:thai_take_away_back_end/logic/blocs/maps/map_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/store_settings/store_settings_bloc.dart';
import 'package:thai_take_away_back_end/data/model/store_settings_model.dart';
import 'package:thai_take_away_back_end/repositores/store_settings_repository.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapCubit _cubit;
  late final MapController _mapController;
  final _distanceController = TextEditingController();

  late double _initialDistanceKm;
  late LatLng _initialCenter;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _cubit = MapCubit();
    _mapController = MapController();

    // fetch store settings after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreSettingsBloc>().add(FetchStoreSettings());
    });

    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return;
      }
    }
    final pos = await Geolocator.getCurrentPosition();
    final latlng = LatLng(pos.latitude, pos.longitude);
    _cubit.centerChanged(latlng);
    _mapController.move(latlng, 13);
    _checkHasChanged();
  }

  void _checkHasChanged() {
    final currentDist = _cubit.state.distanceKm;
    final currentCenter = _cubit.state.center;
    final changed = (currentDist != _initialDistanceKm) ||
        (currentCenter.latitude != _initialCenter.latitude) ||
        (currentCenter.longitude != _initialCenter.longitude);
    setState(() {
      _hasChanged = changed;
    });
  }

  void _resetToInitial() {
    _distanceController.text = _initialDistanceKm.toStringAsFixed(0);
    _cubit.distanceChanged(_initialDistanceKm);
    _cubit.centerChanged(_initialCenter);
    _mapController.move(_initialCenter, 13);
    setState(() {
      _hasChanged = false;
    });
  }

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreSettingsBloc, StoreSettingsState>(
      listener: (context, state) {
        if (state is StoreSettingsLoaded) {
          final s = state.settings;
          _initialCenter =
              LatLng(double.parse(s.latitude.toString()), double.parse(s.longitude.toString()));
          _initialDistanceKm = s.serviceRadius / 1000;
          _distanceController.text =
              _initialDistanceKm.toStringAsFixed(0);
          _cubit.distanceChanged(_initialDistanceKm);
          _cubit.centerChanged(_initialCenter);
          _mapController.move(_initialCenter, 13);
          _checkHasChanged();
        } else if (state is StoreSettingsUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is StoreSettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F9),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Distance input
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Distance (km)',
                      style: TextStyle(
                        color: Color(0xFF5E5483),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _distanceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) {
                          final km =
                              double.tryParse(v) ?? _cubit.state.distanceKm;
                          _cubit.distanceChanged(km);
                          _checkHasChanged();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Map area
                Expanded(
                  flex: 5,
                  child: BlocBuilder<MapCubit, MapState>(
                    builder: (context, state) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    initialCenter: state.center,
                                    initialZoom: 13,
                                    onPositionChanged: (pos, _) {
                                      _cubit.centerChanged(pos.center!);
                                      _checkHasChanged();
                                    },
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      subdomains: const ['a', 'b', 'c'],
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                child: Icon(
                                  Icons.location_on,
                                  size: 44,
                                  color: Color(0xFF5E5483),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Buttons: Get Current, Reset, Save Change
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Get Current
                    TextButton.icon(
                      onPressed: () async {
                        await _initLocation();
                      },
                      icon: const Icon(Icons.my_location,
                          color: Color(0xFF5E5483)),
                      label: const Text(
                        'Get Current',
                        style: TextStyle(
                          color: Color(0xFF5E5483),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Reset
                    TextButton(
                      onPressed: _hasChanged ? _resetToInitial : null,
                      child: const Text('Reset'),
                    ),
                    const SizedBox(width: 12),
                    // Save Change
                    ElevatedButton(
                      onPressed: _hasChanged
                          ? () {
                        final newSettings = StoreSettingsModel(
                          latitude: double.parse(_cubit.state.center.latitude
                              .toString()),
                          longitude: double.parse(_cubit.state.center.longitude
                              .toString()),
                          serviceRadius:
                          (_cubit.state.distanceKm).toInt(),
                        );
                        context
                            .read<StoreSettingsBloc>()
                            .add(UpdateStoreSettings(newSettings));
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _hasChanged
                            ? const Color(0xFF22C453)
                            : const Color(0x8022C453),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: const Size(180, 56),
                      ),
                      child: const Text(
                        'Save Change',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

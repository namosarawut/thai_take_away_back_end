// map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:thai_take_away_back_end/logic/blocs/maps/map_cubit.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapCubit _cubit;
  late final MapController _mapController;
  final _distanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = MapCubit();
    _mapController = MapController();
    _distanceController.text = _cubit.state.distanceKm.toStringAsFixed(0);

    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.deniedForever || perm == LocationPermission.denied) {
        return;
      }
    }
    final pos = await Geolocator.getCurrentPosition();
    final latlng = LatLng(pos.latitude, pos.longitude);
    _cubit.centerChanged(latlng);
    _mapController.move(latlng, 13);
  }

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
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
                      'Distant',
                      style: TextStyle(
                        color: Color(0xFF5E5483),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 200,
                      child: Expanded(
                        child: TextField(
                          controller: _distanceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (v) {
                            final km = double.tryParse(v) ?? _cubit.state.distanceKm;
                            _cubit.distanceChanged(km);
                          },
                        ),
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
                                    },
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      subdomains: const ['a', 'b', 'c'],
                                    ),
                                  ]
                                ),
                              ),
                              // Center marker
                              Positioned(
                                child: Icon(
                                  Icons.location_on,
                                  size: 44,
                                  color: const Color(0xFF5E5483),
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
                // Save button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final dist = _cubit.state.distanceKm;
                        final center = _cubit.state.center;
                        // TODO: บันทึกค่า dist และ center ผ่าน Bloc อื่น หรือ API
                      },
                      child: Container(
                        width: 363,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C453),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Save Change',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

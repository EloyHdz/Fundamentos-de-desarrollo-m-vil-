import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CYBER MAP',
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter:
                  LatLng(latitude, longitude),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),

              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      latitude,
                      longitude,
                    ),
                    width: 100,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        shape:
                            BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(
                              0xFFFF00FF,
                            ).withOpacity(
                              0.8,
                            ),
                            blurRadius:
                                30,
                            spreadRadius:
                                5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Color(
                          0xFFFF00FF,
                        ),
                        size: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Container(
              padding:
                  const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(
                  0xDD141421,
                ),
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
                border: Border.all(
                  color: const Color(
                    0xFF00F7FF,
                  ),
                ),
                boxShadow: const [
                  BoxShadow(
                    color:
                        Color(0x5500F7FF),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Text(
                'UBICACIÓN GUARDADA',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  color:
                      Color(0xFF00F7FF),
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: const Color(
            0xFF141421,
          ),
          border: Border.all(
            color:
                const Color(
              0xFFFF00FF,
            ),
          ),
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            const Text(
              'COORDENADAS',
              style: TextStyle(
                color:
                    Color(0xFFFF00FF),
                fontWeight:
                    FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              'LAT: ${latitude.toStringAsFixed(6)}',
              style: const TextStyle(
                color:
                    Color(0xFF00F7FF),
              ),
            ),

            Text(
              'LNG: ${longitude.toStringAsFixed(6)}',
              style: const TextStyle(
                color:
                    Color(0xFF00F7FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
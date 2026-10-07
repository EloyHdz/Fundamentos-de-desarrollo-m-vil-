import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() =>
      _SelectLocationScreenState();
}

class _SelectLocationScreenState
    extends State<SelectLocationScreen> {
  LatLng selectedPoint =
      const LatLng(22.1565, -100.9855);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SELECCIONAR UBICACIÓN',
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: selectedPoint,
              initialZoom: 13,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedPoint = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: selectedPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFFFF00FF),
                      size: 60,
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
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xDD141421),
                borderRadius:
                    BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF00F7FF),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x5500F7FF),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: const Text(
                'Toca cualquier punto del mapa para seleccionar una ubicación',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF00F7FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        color: const Color(0xFF141421),
        padding: const EdgeInsets.all(15),
        child: Text(
          'Lat: ${selectedPoint.latitude.toStringAsFixed(6)}\n'
          'Lng: ${selectedPoint.longitude.toStringAsFixed(6)}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF00F7FF),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        elevation: 20,
        onPressed: () {
          Navigator.pop(
            context,
            selectedPoint,
          );
        },
        icon: const Icon(
          Icons.check,
        ),
        label: const Text(
          'CONFIRMAR',
        ),
      ),
    );
  }
}
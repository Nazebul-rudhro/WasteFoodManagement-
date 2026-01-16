import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class LocationPickerScreen extends StatefulWidget {
  final Function(LatLng) onPicked;

  const LocationPickerScreen({super.key, required this.onPicked});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? selectedLatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(23.8103, 90.4125), // Dhaka
              zoom: 14,
            ),

            /// 🔴 THIS IS THE MAIN FIX
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
              ),
            },

            onTap: (latLng) {
              setState(() {
                selectedLatLng = latLng;
              });
            },

            markers: selectedLatLng == null
                ? {}
                : {
              Marker(
                markerId: const MarkerId("picked"),
                position: selectedLatLng!,
              ),
            },
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: selectedLatLng == null
                  ? null
                  : () {
                widget.onPicked(selectedLatLng!);
                Navigator.pop(context);
              },
              child: const Text("Confirm Location"),
            ),
          )
        ],
      ),
    );
  }
}

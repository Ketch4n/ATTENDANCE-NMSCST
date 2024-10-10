// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:attendance_nmscst/src/pages/map/functions/get_address.dart';
import 'package:attendance_nmscst/src/pages/map/permission/user_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};

  static LatLng? _centerPosition;

  static String _address = "Click the icon or drag the screen";

  @override
  void initState() {
    super.initState();
    _locateUser();
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Future<void> _locateUser() async {
    LatLng position = await getUserLocation();
    setState(() {
      _centerPosition = position;
      _updateMap();
    });
  }

  void _updateMap() {
    if (mapController != null) {
      mapController!
          .animateCamera(CameraUpdate.newLatLngZoom(_centerPosition!, 18));
      _updateAddress();
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('current-location'),
            position: _centerPosition!),
      );
    }
  }

  Future<void> _updateAddress() async {
    String address = await fetchAddress(_centerPosition!);
    setState(() {
      _address = address;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: _centerPosition != null
          ? Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: _centerPosition!, zoom: 18),
                  onCameraMove: (position) => _centerPosition = position.target,
                  onCameraIdle: _updateAddress,
                  markers: _markers,
                ),
                Positioned(
                  bottom: 20,
                  left: 150,
                  right: 150,
                  child: FloatingActionButton(
                    onPressed: _locateUser,
                    child: const Icon(Icons.my_location),
                  ),
                ),
                const Center(
                  child: Icon(Icons.location_pin, size: 50, color: Colors.red),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.yellow,
                    child: Text(
                      _address,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 100,
                  right: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_address);
                    },
                    child: const Text('Save'),
                  ),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

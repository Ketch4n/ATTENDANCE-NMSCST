// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<String> fetchAddress(LatLng position) async {
  try {
    final response = await http.post(
      Uri.parse("${Servername.host}geodata"),
      body: {'latlng': '${position.latitude},${position.longitude}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        final components = data['results'][1]['address_components'];

        return extractAddress(components);
      }
    }
  } catch (e) {
    print(e);
  }
  return 'Unknown Location';
}

String extractAddress(List<dynamic> components) {
  String street = '', city = '', sublocality = '', subAdministrativeArea = '';
  for (var component in components) {
    final types = component['types'];
    if (types.contains('establishment')) {
      street = component['long_name'];
    } else if (types.contains('locality'))
      city = component['long_name'];
    else if (types.contains('sublocality'))
      sublocality = component['long_name'];
    else if (types.contains('administrative_area_level_2'))
      subAdministrativeArea = component['long_name'];
  }
  return '$street $sublocality $city $subAdministrativeArea'.trim();
}

import 'dart:async';
import 'dart:convert';
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:attendance_nmscst/src/pages/establishment/model/establishment_model.dart';
import 'package:http/http.dart' as http;

Future<void> getEstablishment(
    StreamController<List<EstablishmentModel>> stream) async {
  try {
    final response = await http.get(
      Uri.parse('${Servername.host}establishment'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('data')) {
        List<dynamic> data = jsonResponse['data'];
        List<EstablishmentModel> establishment =
            data.map((json) => EstablishmentModel.fromJson(json)).toList();

        stream.add(establishment);
      } else {
        print('No data found in response.');
        stream.add([]);
      }
    } else {
      print('Failed to load data. HTTP status code: ${response.statusCode}');
      stream.add([]);
    }
  } catch (e) {
    print('Error occurred: $e');
    stream.add([]);
  }
}

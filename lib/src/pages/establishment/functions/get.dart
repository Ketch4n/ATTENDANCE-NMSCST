import 'dart:async';
import 'package:attendance_nmscst/src/data/services/api_service.dart';
import 'package:attendance_nmscst/src/pages/establishment/model/establishment_model.dart';

Future<void> getEstablishment(StreamController<List<EstablishmentModel>> stream,
    {bool isDemoMode = false}) async {
  try {
    final jsonResponse = await ApiService.get(
      'establishment',
      isDemoMode: isDemoMode,
    );

    if (jsonResponse.containsKey('data')) {
      List<dynamic> data = jsonResponse['data'];
      List<EstablishmentModel> establishment =
          data.map((json) => EstablishmentModel.fromJson(json)).toList();

      stream.add(establishment);
    } else {
      stream.add([]);
    }
  } catch (e) {
    stream.add([]);
  }
}

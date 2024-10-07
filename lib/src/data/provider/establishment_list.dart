import 'package:attendance_nmscst/src/pages/establishment/model/establishment_model.dart';
import 'package:flutter/material.dart';

class EstablishmentList with ChangeNotifier {
  // Private field to hold the list of establishments
  List<EstablishmentModel> _establishments = [];

  // Getter to access the list of establishments
  List<EstablishmentModel> get establishments => _establishments;

  // Setter to update the list of establishments
  set establishments(List<EstablishmentModel> newEstablishments) {
    _establishments = newEstablishments;
    notifyListeners(); // Notify listeners about the change
  }

  // Optionally, you can add methods for modifying the list
  void addEstablishment(EstablishmentModel establishment) {
    _establishments.add(establishment);
    notifyListeners();
  }

  void removeEstablishment(EstablishmentModel establishment) {
    _establishments.remove(establishment);
    notifyListeners();
  }

  void clearEstablishments() {
    _establishments.clear();
    notifyListeners();
  }
}

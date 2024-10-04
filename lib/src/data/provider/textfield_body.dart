import 'package:flutter/foundation.dart';

class TextfieldBody with ChangeNotifier {
  static List<String?> lines = [];

  List<String?> get authors =>
      List.from(lines); // Use this method to retrieve the list

  void addBody(List<String?> newAuthors) {
    lines = newAuthors.take(4).toList(); // Ensure no more than 4 authors
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import 'package:random_flutter/model/places.dart';

class LocationProvider extends ChangeNotifier {
  final List<Places> _places = [];

  List<Places> get places {
    return [..._places];
  }

  void addPlace(Places place) {
    _places.add(place);
    notifyListeners();
  }

  void removePlace(String id) {
    _places.removeWhere((place) => place.id == id);
    notifyListeners();
  }
}

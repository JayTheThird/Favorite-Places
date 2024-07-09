import 'dart:io';

import 'package:favorite_places/model/place_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPlacesBloc extends Cubit<List<Place>> {
  UserPlacesBloc() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = Place(place: title, image: image);
    emit([newPlace, ...state]);
  }
}

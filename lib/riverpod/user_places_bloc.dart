import 'package:favorite_places/model/place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPlacesBloc extends Cubit<List<Place>> {
  UserPlacesBloc() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(place: title);
    emit([newPlace, ...state]);
  }
}

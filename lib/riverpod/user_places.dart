import 'package:favorite_places/model/place.dart';
import 'package:riverpod/riverpod.dart';

class UserPlacesNotifiers extends StateNotifier<List<Place>> {
  UserPlacesNotifiers() : super(const []);

  void addPlace(Place place) {
    final newPlace = Place(place: place.place);
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider((ref) => UserPlacesNotifiers());

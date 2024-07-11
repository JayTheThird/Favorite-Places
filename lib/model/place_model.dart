import 'dart:io';
// import 'package:favorite_places/model/location_model.dart';
import 'package:uuid/uuid.dart';




const uuid = Uuid();

class Place {
  final String id;
  final String place;
  final File image;
  // final PlaceLocation location;

  Place({
    required this.place,
    required this.image,
    // required this.location,
  }) : id = uuid.v4();
}

import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  String id;
  String place;
  File image;

  Place({required this.place, required this.image}) : id = uuid.v4();
}

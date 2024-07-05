import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  String id;
  String place;

  Place({required this.place}) : id = uuid.v4();
}

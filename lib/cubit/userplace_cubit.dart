import 'dart:io';

import 'package:favorite_places/model/location_model.dart';
import 'package:favorite_places/model/place_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE favorite_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)",
      );
    },
    version: 1,
  );

  return db;
}

class UserPlacesBloc extends Cubit<List<Place>> {
  UserPlacesBloc() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query("favorite_places");
    final place = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            place: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                address: row['address'] as String),
          ),
        )
        .toList();
        
    emit(place);
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    print("old path : ${image.path}");
    final newDir = await syspath.getApplicationDocumentsDirectory();
    //     Gets the part of [path] after the last separator.
    // p.basename('path/to/foo.dart'); // -> 'foo.dart'
    final newPath = path.basename(image.path);
    final updatedImagePath = await image.copy("${newDir.path}/$newPath");
    print("new path $updatedImagePath");

    final newPlace = Place(place: title, image: updatedImagePath, location: location);
    final db = await _getDatabase();
    db.insert(
      "favorite_places",
      {
        'id': newPlace.id,
        'title': newPlace.place,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );

    emit([newPlace, ...state]);
  }
}

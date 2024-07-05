import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/riverpod/user_places_bloc.dart';
import 'package:favorite_places/screen/add_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Places"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddPlaces(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<UserPlacesBloc, List<Place>>(
        builder: (context, place) {
          return PlacesList(places: place);
        },
      ),
    );
  }
}

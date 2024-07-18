import 'package:favorite_places/model/place_model.dart';
import 'package:favorite_places/cubit/userplace_cubit.dart';
import 'package:favorite_places/screen/add_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late Future<void> _placeFuture;

  @override
  void initState() {
    super.initState();
    final placeBloc = BlocProvider.of<UserPlacesBloc>(context);
    _placeFuture = placeBloc.loadPlaces();
  }

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
      body: FutureBuilder(
          future: _placeFuture,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: LoadingAnimationWidget.discreteCircle(color: Colors.purple, size: 30),
                  )
                : BlocBuilder<UserPlacesBloc, List<Place>>(
                    builder: (context, place) {
                      return PlacesList(places: place);
                    },
                  );
          }),
    );
  }
}

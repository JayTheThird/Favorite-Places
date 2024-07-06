import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/screen/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No Places Added Yet!",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(
          places[index].place,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
        ),
        onTap: () => Navigator.of(ctx).push(
          MaterialPageRoute(
            builder: (ctx) => PlaceDetails(place: places[index]),
          ),
        ),
      ),
    );
  }
}

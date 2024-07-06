import 'package:favorite_places/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.place),
      ),
      body: Center(
        child: Text(
          place.id,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}

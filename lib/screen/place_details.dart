import 'package:favorite_places/model/place_model.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});
  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final lag = place.location.longitude;
    final url =
        'https://apis.mapmyindia.com/advancedmaps/v1/2b9fc1ff5d230f67dbb9769452258361/still_image?center=$lat,$lag&zoom=17&size=600x300&ssf=1&markers=$lat,$lag';

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.place),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Hero(
              tag: place.id,
              child: Image.file(
                place.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Container(
                      height: 320,
                      width: double.infinity,
                      alignment: Alignment.center,
                      // clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        locationImage,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black26,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Text(
                          place.location.address,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

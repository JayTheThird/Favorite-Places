import 'dart:convert';

import 'package:favorite_places/model/location_model.dart';
import 'package:favorite_places/screen/map.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:mappls_gl/mappls_gl.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSelectedLocation,
  });

  final void Function(PlaceLocation location) onSelectedLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool _isCurrentLocation = false;
  PlaceLocation? _pickedLocation;

  Future getLocation(double lat, double lng) async {
    final url = Uri.parse(
      "https://apis.mapmyindia.com/advancedmaps/v1/2b9fc1ff5d230f67dbb9769452258361/rev_geocode?lat=$lat&lng=$lng",
    );

    final response = await http.get(url);
    final resData = json.decode(response.body);

    final address = resData["results"][0]["formatted_address"];
    print(address);
    print(lat);
    print(lng);

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      _isCurrentLocation = false;
    });

    widget.onSelectedLocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isCurrentLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lng == null || lat == null) return;

    getLocation(lat, lng);
  }

  String get locationImage {
    final lat = _pickedLocation!.latitude;
    final lag = _pickedLocation!.longitude;
    final url =
        'https://apis.mapmyindia.com/advancedmaps/v1/2b9fc1ff5d230f67dbb9769452258361/still_image?center=$lat,$lag&zoom=17&size=600x300&ssf=1&markers=$lat,$lag';
    print(url);
    return url;
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (pickedLocation == null) return;

    getLocation(pickedLocation.latitude, pickedLocation.longitude);
  }

  getData() {
    if (_isCurrentLocation) {
      return LoadingAnimationWidget.prograssiveDots(
        color: Colors.purple,
        size: 40,
      );
    } else {
      return Text(
        "No Location",
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          child: _pickedLocation == null
              ? getData()
              : Image.network(
                  locationImage,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text("Get Current Location"),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              label: const Text("Select On Map"),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}

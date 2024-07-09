import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool _isCurrentLocation = false;

  void getCurrentLocation() async {
    Location location = new Location();

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

    setState(() {
      _isCurrentLocation = false;
    });

    print(locationData.altitude);
    print(locationData.latitude);
    print(locationData.accuracy);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _isCurrentLocation
              ? LoadingAnimationWidget.prograssiveDots(
                  color: Colors.purple,
                  size: 40,
                )
              : Text(
                  "No Location",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              label: const Text("Get Current Location"),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text("Select On Map"),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}

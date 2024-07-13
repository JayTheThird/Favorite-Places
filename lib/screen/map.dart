import 'package:flutter/material.dart';
import 'package:favorite_places/model/location_model.dart';
import 'package:mappls_gl/mappls_gl.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 28.7041,
      longitude: 77.1025,
      address: "",
    ),
    this.isLocationPicked = true,
  });

  final PlaceLocation location;
  final bool isLocationPicked;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapplsMapController? mapplsMapController;
  LatLng? _pickedLocation;

  @override
  void initState() {
    MapplsAccountManager.setMapSDKKey("2b9fc1ff5d230f67dbb9769452258361");
    MapplsAccountManager.setRestAPIKey("2b9fc1ff5d230f67dbb9769452258361");
    MapplsAccountManager.setAtlasClientId(
      "96dHZVzsAuuJelfP6148rprhRj9v_aYWfGDVNvjcKMPxTL0YNTm7P1AVbWibfUYL1pG7jwco1hmhBeYOdH1XtA==",
    );
    MapplsAccountManager.setAtlasClientSecret(
      "lrFxI-iSEg-fIXbJ6hyYkXApLLCz30mnv4coXbxiadoxFTNMvtUkN95Myuf_oax2RaTPt6SMoPeTS2CpgFvydN7rz9UoTfQv",
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isLocationPicked ? "Pick Your Location" : "Your Location",
        ),
        actions: [
          if (widget.isLocationPicked)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save_alt),
            ),
        ],
      ),
      body: MapplsMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 14.0,
        ),
        onMapCreated: (map) {
          mapplsMapController = map;
          mapplsMapController!.addSymbol(
            SymbolOptions(
              geometry: _pickedLocation ??
                  LatLng(
                    widget.location.latitude,
                    widget.location.longitude,
                  ),
            ),
          );
        },
        onMapClick: widget.isLocationPicked
            ? (point, coordinates) {
                setState(() {
                  _pickedLocation = coordinates;
                  mapplsMapController!.clearSymbols();
                  mapplsMapController!.addSymbol(
                    SymbolOptions(
                      geometry: coordinates,
                    ),
                  );
                });
              }
            : (point, coordinates) {
                setState(() {
                  _pickedLocation = coordinates;
                });
              },
        compassEnabled: true,
        compassViewPosition: CompassViewPosition.TopLeft,
        logoViewPosition: LogoViewPosition.BottomRight,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';

import '../../../components/progress_indicator.dart';

class OSFMap extends StatelessWidget {
  final MapController mapController;
  final Location locationFirst;
  final Location locationLast;
  const OSFMap(
      {Key? key,
      required this.mapController,
      required this.locationFirst,
      required this.locationLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      mapIsLoading: const CargoBikeProgressIndicator(),
      controller: mapController,
      trackMyPosition: false,
      initZoom: 12,
      minZoomLevel: 2,
      maxZoomLevel: 18,
      stepZoom: 1.0,
      onMapIsReady: (isReady) {
        if (isReady) {
          getMap(locationFirst, locationLast);
        }
      },
      userLocationMarker: UserLocationMaker(
        personMarker: const MarkerIcon(
          icon: Icon(
            Icons.location_history_rounded,
            color: Colors.red,
            size: 48,
          ),
        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(
            Icons.double_arrow,
            size: 48,
          ),
        ),
      ),
      roadConfiguration: RoadConfiguration(
        startIcon: const MarkerIcon(
          icon: Icon(
            Icons.person,
            size: 64,
            color: Colors.brown,
          ),
        ),
        roadColor: Colors.black,
      ),
      markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
        icon: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
        ),
      )),
    );
  }

  void getMap(location1, location2) async {
    // RoadInfo roadInfo =
    await mapController.drawRoad(
      GeoPoint(latitude: location1.latitude, longitude: location1.longitude),
      GeoPoint(latitude: location2.latitude, longitude: location2.longitude),
      roadType: RoadType.bike,
      roadOption: const RoadOption(
        roadWidth: 10,
        roadColor: Colors.blue,
        showMarkerOfPOI: false,
        zoomInto: true,
      ),
    );
    // print("${roadInfo.distance}km");
    // print("${(roadInfo.duration)}sec");
  }
}

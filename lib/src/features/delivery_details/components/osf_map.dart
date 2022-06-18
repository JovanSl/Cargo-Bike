import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import '../../../models/location.dart';

import '../../../components/progress_indicator.dart';

class OSFMap extends StatelessWidget {
  final MapController mapController;
  final Location? locationFirst;
  final Location? locationLast;
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
      androidHotReloadSupport: true,
      controller: mapController,
      trackMyPosition: false,
      initZoom: 12,
      minZoomLevel: 2,
      maxZoomLevel: 18,
      stepZoom: 1.0,
      onMapIsReady: (isReady) {
        if (isReady) {
          getMap(
            locationFirst!.lat,
            locationFirst!.lng,
            locationLast!.lat,
            locationLast!.lng,
          );
        }
      },
    );
  }

  void getMap(
    locationFirstLat,
    locationFirstLng,
    locationLastLat,
    locationLastLng,
  ) async {
    // RoadInfo roadInfo =
    await mapController.drawRoad(
      GeoPoint(latitude: locationFirstLat, longitude: locationFirstLng),
      GeoPoint(latitude: locationLastLat, longitude: locationLastLng),
      roadType: RoadType.bike,
      roadOption: const RoadOption(
        roadWidth: 10,
        roadColor: Colors.blue,
        showMarkerOfPOI: true,
        zoomInto: true,
      ),
    );
    // print("${roadInfo.distance}km");
    // print("${(roadInfo.duration)}sec");
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/location.dart';

class LocationPickerMap extends StatelessWidget {
  const LocationPickerMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double lng = 0, lat = 0;
    final PopupController _popupLayerController = PopupController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, Location(lat: lat, lng: lng));
        },
        child: const Icon(Icons.save),
      ),
      body: FlutterMap(
        options: MapOptions(
          plugins: [
            DragMarkerPlugin(),
          ],
          allowPanningOnScrollingParent: false,
          center: LatLng(45.2623752, 19.84910386),
          zoom: 12.0,
          onTap: (_, __) => _popupLayerController
              .hideAllPopups(), // Hide popup when the map is tapped.
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c']),
          DragMarkerPluginOptions(
            markers: [
              DragMarker(
                point: LatLng(45.2623752, 19.84910386),
                width: 80.0,
                height: 80.0,
                offset: const Offset(0.0, -8.0),
                builder: (ctx) => const Icon(Icons.location_on, size: 50),
                onDragEnd: (details, point) {
                  lng = point.longitude;
                  lat = point.latitude;
                },
                onDragUpdate: (details, point) {},
                feedbackBuilder: (ctx) =>
                    const Icon(Icons.edit_location, size: 75),
                feedbackOffset: const Offset(0.0, -9.0),
                updateMapNearEdge: true,
                nearEdgeRatio: 0.7,
                nearEdgeSpeed: 1.0,
                rotateMarker: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

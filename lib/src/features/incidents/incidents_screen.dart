import 'package:flutter/material.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:math';

class IncidentScreen extends StatefulWidget {
  static const routName = '/courrier';
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  State<IncidentScreen> createState() => _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {
  final PopupController _popupLayerController = PopupController();

  final List<LatLng> _markerPositions = [
    LatLng(44.421, 10.404),
    LatLng(45.683, 10.839),
    LatLng(45.246, 5.783),
  ];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 100; i++) {
      var lng = Random().nextInt(20);
      var rng = Random().nextInt(20);
      _markerPositions.add(LatLng(44.421 + lng, 10.404 + rng));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('KURIR')),
      body: FlutterMap(
        options: MapOptions(
          plugins: [
            DragMarkerPlugin(),
          ],
          allowPanningOnScrollingParent: false,
          center: LatLng(44.421, 10.404),
          zoom: 4.0,
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
                point: LatLng(45.2131, 11.6765),
                width: 80.0,
                height: 80.0,
                offset: const Offset(0.0, -8.0),
                builder: (ctx) => const Icon(Icons.location_on, size: 50),
                onDragStart: (details, point) => print("Start point $point"),
                onDragEnd: (details, point) => print("End point $point"),
                onDragUpdate: (details, point) {},
                onTap: (point) {
                  print("on tap");
                },
                onLongPress: (point) {
                  print("on long press");
                },
                feedbackBuilder: (ctx) =>
                    const Icon(Icons.edit_location, size: 75),
                feedbackOffset: const Offset(0.0, -9.0),
                updateMapNearEdge:
                    true, // Experimental, move the map when marker close to edge
                nearEdgeRatio: 0.7, // Experimental
                nearEdgeSpeed: 1.0, // Experimental
                rotateMarker: true, // Experimental
              ),
            ],
          ),
        ],
        // children: const [
        //   // TileLayerWidget(
        //   //   options: TileLayerOptions(
        //   //     //https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png
        //   //     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        //   //     subdomains: ['a', 'b', 'c'],
        //   //   ),
        //   // ),
        //   // PopupMarkerLayerWidget(
        //   //   options: PopupMarkerLayerOptions(
        //   //     popupController: _popupLayerController,
        //   //     markers: _markers,
        //   //     markerRotateAlignment:
        //   //         PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
        //   //     popupBuilder: (BuildContext context, Marker marker) =>
        //   //         MapPopup(marker),
        //   //   ),
        //   // ),
        // ],
      ),
    );
  }

  List<Marker> get _markers => _markerPositions
      .map(
        (markerPosition) => Marker(
          point: markerPosition,
          width: 40,
          height: 40,
          builder: (_) => const Icon(Icons.location_on, size: 40),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
      )
      .toList();
}

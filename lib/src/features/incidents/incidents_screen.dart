import 'package:cargo_bike/src/components/progress_indicator.dart';
import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/new_incident/new_incident_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bloc/incident_bloc.dart';
import 'components/map_popup.dart';

class IncidentScreen extends StatefulWidget {
  static const routName = '/courrier';
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  State<IncidentScreen> createState() => _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {
  final PopupController _popupLayerController = PopupController();

  final List<LatLng> _markerPositions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CargoBikeColors.lightGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewIncidentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: CargoBikeColors.lightGreen,
        title: Text(AppLocalizations.of(context)!.incidentsScreenText),
      ),
      body: BlocConsumer<IncidentBloc, IncidentState>(
        listener: (context, state) {
          if (state is IncidentSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.incidentCreated)));
          }
        },
        builder: (context, state) {
          if (state is IncidentLoadingState) {
            return const CargoBikeProgressIndicator();
          } else if (state is AllIncidentsState) {
            for (int i = 0; i < state.allIncidents.length; i++) {
              _markerPositions.add(LatLng(state.allIncidents[i].location.lat,
                  state.allIncidents[i].location.lng));
            }
            return FlutterMap(
              options: MapOptions(
                allowPanningOnScrollingParent: false,
                center: LatLng(45.2623752, 19.84910386),
                zoom: 12.0,
                onTap: (_, __) => _popupLayerController
                    .hideAllPopups(),
              ),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                    //https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    popupController: _popupLayerController,
                    markers: _markers,
                    markerRotateAlignment:
                        PopupMarkerLayerOptions.rotationAlignmentFor(
                            AnchorAlign.top),
                    popupBuilder: (BuildContext context, Marker marker) =>
                        MapPopup(
                      marker,
                      text: '',
                    ),
                  ),
                ),
              ],
            );
          } else if (state is IncidentErrorState) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

//markers
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

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/new_incident/components/location_picker_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart' as lokacija;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/multi_line_input_field.dart';
import '../../models/incident.dart';
import '../../models/location.dart';
import '../incidents/bloc/incident_bloc.dart';

class NewIncidentScreen extends StatefulWidget {
  static const routeName = '/new_incident';
  const NewIncidentScreen({Key? key}) : super(key: key);

  @override
  State<NewIncidentScreen> createState() => _NewIncidentScreenState();
}

class _NewIncidentScreenState extends State<NewIncidentScreen> {
  final TextEditingController message = TextEditingController();
  double? lng = 0, lat = 0;
  Location pickedLocation = Location(lat: 0, lng: 0);
  List<geocoding.Placemark>? placemarks;

  @override
  Widget build(BuildContext context) {
    lokacija.Location location = lokacija.Location();
    bool _serviceEnabled = false;
    lokacija.PermissionStatus _permissionGranted;
    lokacija.LocationData _locationData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CargoBikeColors.lightGreen,
        title: Text(AppLocalizations.of(context)!.addIncident),
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            MultiLineInputField(
              lable: AppLocalizations.of(context)!.describeIncident,
              controller: message,
            ),
            Text(placemarks?.first.toString() == null
                ? ''
                : placemarks!.first.street.toString() +
                    ", " +
                    placemarks!.first.locality.toString()),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                _serviceEnabled = await location.serviceEnabled();
                if (!_serviceEnabled) {
                  _serviceEnabled = await location.requestService();
                  if (!_serviceEnabled) {
                    return;
                  }
                }

                _permissionGranted = await location.hasPermission();
                if (_permissionGranted == lokacija.PermissionStatus.denied) {
                  _permissionGranted = await location.requestPermission();
                  if (_permissionGranted != lokacija.PermissionStatus.granted) {
                    return;
                  }
                }

                _locationData = await location.getLocation();
                placemarks = await geocoding.placemarkFromCoordinates(
                    _locationData.latitude!, _locationData.longitude!);
                setState(() {
                  lng = _locationData.longitude;
                  lat = _locationData.latitude;
                  placemarks = placemarks;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gps_fixed,
                    color: CargoBikeColors.lightGreen,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(AppLocalizations.of(context)!.locationCurrent),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final pickedLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationPickerMap()),
                );
                placemarks = await geocoding.placemarkFromCoordinates(
                    pickedLocation.lat, pickedLocation.lng);
                setState(() {
                  lng = pickedLocation.lng;
                  lat = pickedLocation.lat;

                  placemarks = placemarks;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: CargoBikeColors.lightGreen,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(AppLocalizations.of(context)!.locationFromMap),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(125, 50),
                    primary: CargoBikeColors.lightGreen,
                  ),
                  onPressed: () {
                    context.read<IncidentBloc>().add(
                          CreateIncidentEvent(
                            Incident(
                                location: Location(
                                  lng: lng ?? 0,
                                  lat: lat ?? 0,
                                ),
                                message: message.text),
                          ),
                        );
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.submit)),
            )
          ],
        ),
      ),
    );
  }
}

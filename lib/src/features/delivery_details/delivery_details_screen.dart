import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/delivery_details/components/osf_map.dart';
import 'package:cargo_bike/src/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';
  final Delivery delivery;
  const DeliveryDetailsScreen({Key? key, required this.delivery})
      : super(key: key);

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 45.2623752, longitude: 19.84910386),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.details),
        backgroundColor: CargoBikeColors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 300, maxHeight: 300),
              child: OSFMap(
                mapController: mapController,
                locationFirst: widget.delivery.sender.location,
                locationLast: widget.delivery.recipient.location,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 300, maxWidth: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: CargoBikeColors.darkGreen,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 5.0, top: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.from + ":"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(AppLocalizations.of(context)!.name +
                                    ':' +
                                    widget.delivery.sender.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.phoneNumber +
                                        ':' +
                                        widget.delivery.sender.phone),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.email +
                                        ':' +
                                        widget.delivery.sender.email),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 300, maxWidth: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: CargoBikeColors.darkGreen,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 5.0, top: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.to + ":"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(AppLocalizations.of(context)!.name +
                                    ':' +
                                    widget.delivery.recipient.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.phoneNumber +
                                        ':' +
                                        widget.delivery.recipient.phone),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(AppLocalizations.of(context)!
                                        .additionalInfo +
                                    ':' +
                                    widget.delivery.recipient.additionalInfo),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/delivery_details/bloc/delivery_details_bloc.dart';
import 'package:cargo_bike/src/features/delivery_details/components/osf_map.dart';
import 'package:cargo_bike/src/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../main/bloc/main_list_bloc.dart';
import 'components/delete_delivery_alert.dart';
import 'components/delivery_text_field.dart';

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
    return BlocConsumer<DeliveryDetailsBloc, DeliveryDetailsState>(
      listener: (context, state) {
        if (state is DeleteDeliveryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.error)));
        }
        if (state is DeleteDeliverySuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.deleteSuccessful)));
          Navigator.pop(context);
          context.read<MainListBloc>().add(GetAllDeliveries());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.details),
            backgroundColor: CargoBikeColors.lightGreen,
            actions: [
              GestureDetector(
                  onTap: () =>
                      deleteDeliveryDialog(context, widget.delivery.id),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.delete_forever_sharp,
                      size: 25,
                    ),
                  )),
            ],
          ),
          body: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxHeight: MediaQuery.of(context).size.height * 0.35,
                ),
                child: OSFMap(
                  mapController: mapController,
                  locationFirst: widget.delivery.sender.location,
                  locationLast: widget.delivery.recipient.location,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                child: Row(
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
                                        AppLocalizations.of(context)!.from +
                                            ":"),
                                  ),
                                  DeliveryTextField(
                                    child: Text(
                                        AppLocalizations.of(context)!.name +
                                            ':' +
                                            widget.delivery.sender.name),
                                  ),
                                  DeliveryTextField(
                                    child: Text(AppLocalizations.of(context)!
                                            .phoneNumber +
                                        ':' +
                                        widget.delivery.sender.phone),
                                  ),
                                  DeliveryTextField(
                                    child: Text(
                                        AppLocalizations.of(context)!.email +
                                            ':' +
                                            widget.delivery.sender.email),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_downward,
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                  DeliveryTextField(
                                    child: Text(
                                        AppLocalizations.of(context)!.name +
                                            ':' +
                                            widget.delivery.recipient.name),
                                  ),
                                  DeliveryTextField(
                                    child: Text(AppLocalizations.of(context)!
                                            .phoneNumber +
                                        ':' +
                                        widget.delivery.recipient.phone),
                                  ),
                                  DeliveryTextField(
                                    child: Text(AppLocalizations.of(context)!
                                            .additionalInfo +
                                        ':' +
                                        widget
                                            .delivery.recipient.additionalInfo),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

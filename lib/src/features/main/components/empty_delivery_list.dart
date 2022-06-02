import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyDeliveryList extends StatelessWidget {
  const EmptyDeliveryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.directions_bike,
          size: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.noDeliveries,
          style: const TextStyle(fontSize: 20),
        )
      ],
    ));
  }
}

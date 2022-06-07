import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';
  final Delivery delivery;
  const DeliveryDetailsScreen({Key? key, required this.delivery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.details),
        backgroundColor: CargoBikeColors.lightGreen,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 300, maxWidth: 300),
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
                        child: Text(AppLocalizations.of(context)!.from + ":"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(AppLocalizations.of(context)!.name +
                            ':' +
                            delivery.sender.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(AppLocalizations.of(context)!.phoneNumber +
                            ':' +
                            delivery.sender.phone),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(AppLocalizations.of(context)!.email +
                            ':' +
                            delivery.sender.email),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.arrow_downward,
                size: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 300, maxWidth: 300),
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
                        child: Text(AppLocalizations.of(context)!.to + ":"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(AppLocalizations.of(context)!.name +
                            ':' +
                            delivery.recipient.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(AppLocalizations.of(context)!.phoneNumber +
                            ':' +
                            delivery.recipient.phone),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                            AppLocalizations.of(context)!.additionalInfo +
                                ':' +
                                delivery.recipient.additionalInfo),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

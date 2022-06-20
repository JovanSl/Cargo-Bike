import 'package:cargo_bike/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/delivery_details_bloc.dart';

Future<void> deleteDeliveryDialog(context, id) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteConfirm,
            style: const TextStyle(color: Colors.black)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<DeliveryDetailsBloc>()
                            .add(DeleteDeliveryEvent(id: id));
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.yes),
                      style: ElevatedButton.styleFrom(
                          primary: CargoBikeColors.darkGreen),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.no,
                          style: const TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      );
    },
  );
}

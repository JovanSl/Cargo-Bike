import 'dart:async';

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/authentication/bloc/auth_bloc.dart';
import 'package:cargo_bike/src/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (context.read<AuthRepository>().checkIfVerified()) {
        context.read<AuthBloc>().add(CheckUserStatusEvent());
        timer.cancel();
      }
    });
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.registrationSuccesfull,
            ),
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context)!.noMail,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: CargoBikeColors.lightGreen),
              child: Text(AppLocalizations.of(context)!.sendAgain),
              onPressed: () {
                context.read<AuthBloc>().add(SendVerificationEmailEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}

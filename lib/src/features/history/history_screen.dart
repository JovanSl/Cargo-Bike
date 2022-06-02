import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/history/bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/delivery_list_tile.dart';
import '../../components/progress_indicator.dart';
import '../main/components/empty_delivery_list.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/history';
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.history),
        backgroundColor: CargoBikeColors.lightGreen,
      ),
      body: Center(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: ((context, state) {
            if (state is AllHistoryLoadingState) {
              return const CargoBikeProgressIndicator();
            }
            if (state is NoHistoryState) {
              return const EmptyDeliveryList();
            }
            if (state is AllHistoryState) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: state.delivery.length,
                  itemBuilder: (BuildContext context, int index) =>
                      DeliveryListTile(delivery: state.delivery[index]),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/main/bloc/main_list_bloc.dart';
import 'package:cargo_bike/src/features/new_delivery/new_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/progress_indicator.dart';
import '../new_delivery/bloc/new_delivery_bloc.dart';
import 'components/order_list_tile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.test),
        backgroundColor: CargoBikeColors.lightGreen,
      ),
      body: BlocListener<NewDeliveryBloc, NewDeliveryState>(
        listener: (context, state) {
          if (state is AddDeliverySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .successfullyCreatedDelivery)));
            context.read<MainListBloc>().add(GetAllOrders());
          }
        },
        child: BlocBuilder<MainListBloc, MainListState>(
          builder: ((context, state) {
            if (state is AllOrdersLoadingState) {
              return const CargoBikeProgressIndicator();
            }
            if (state is AllOrdersState) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: state.order.length,
                  itemBuilder: (BuildContext context, int index) =>
                      DeliveryListTile(delivery: state.order[index]),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CargoBikeColors.lightGreen,
        onPressed: () {
          context.read<NewDeliveryBloc>().add(SetDeliveryToInitial());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewOrderScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

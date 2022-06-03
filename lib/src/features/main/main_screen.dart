import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/main/bloc/main_list_bloc.dart';
import 'package:cargo_bike/src/features/new_delivery/new_order_screen.dart';
import 'package:cargo_bike/src/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/progress_indicator.dart';
import '../new_delivery/bloc/new_delivery_bloc.dart';
import '../../components/delivery_list_tile.dart';
import 'components/empty_delivery_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
            context.read<MainListBloc>().add(GetAllDeliveries());
          }
          if (state is UserLoadedState) {
            context.read<MainListBloc>().add(GetAllDeliveries());
          }
        },
        child: BlocBuilder<MainListBloc, MainListState>(
          builder: ((context, state) {
            if (state is AllDeliveriesLoadingState) {
              return const CargoBikeProgressIndicator();
            }
            if (state is NoDeliveriesState) {
              return GestureDetector(
                  onTap: _getData, child: const EmptyDeliveryList());
            }
            if (state is AllDeliveriesState) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RefreshIndicator(
                  onRefresh: _getData,
                  child: ListView.builder(
                    itemCount: state.delivery.length,
                    itemBuilder: (BuildContext context, int index) =>
                        DeliveryListTile(delivery: state.delivery[index]),
                  ),
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

  Future<void> _getData() async {
    context.read<MainListBloc>().add(GetAllDeliveries());
  }
}

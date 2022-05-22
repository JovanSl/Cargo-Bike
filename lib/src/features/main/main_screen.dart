import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/new_order/new_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../new_order/bloc/new_order_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NewOrderBloc, NewOrderState>(
        listener: (context, state) {
          if (state is AddOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Successfully created order')));
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text('Main Screen'),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CargoBikeColors.lightGreen,
        onPressed: () {
          context.read<NewOrderBloc>().add(SetOrderToInitial());
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

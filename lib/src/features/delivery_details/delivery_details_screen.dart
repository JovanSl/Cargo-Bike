import 'package:cargo_bike/src/constants/colors.dart';
import 'package:flutter/material.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';
  const DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery details'),
        backgroundColor: CargoBikeColors.lightGreen,
      ),
    );
  }
}

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text('Main Screen'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CargoBikeColors.lightGreen,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

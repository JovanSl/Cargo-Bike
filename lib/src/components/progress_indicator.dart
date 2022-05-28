import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CargoBikeProgressIndicator extends StatelessWidget {
  const CargoBikeProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: CargoBikeColors.lightGreen,
      ),
    );
  }
}

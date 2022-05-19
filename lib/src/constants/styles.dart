import 'package:flutter/material.dart';

class CargoBikeStyle {
  static final CargoBikeTextStyle textStyle = CargoBikeTextStyle();
}

class CargoBikeTextStyle {
  final TextStyle errorText = const TextStyle(
    color: Colors.red,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    fontFamily: 'Montserrat',
    fontStyle: FontStyle.normal,
  );
  final TextStyle heading1Text = const TextStyle(
    color: Colors.black,
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    fontFamily: 'Montserrat',
    fontStyle: FontStyle.normal,
  );
  final TextStyle heading4Text = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    fontFamily: 'Montserrat',
    fontStyle: FontStyle.normal,
  );
}

import 'package:flutter_map/flutter_map.dart';

class TextMarker extends Marker {
  final String text;

  TextMarker(
      {required this.text,
      required super.point,
      required super.builder,
      super.anchorPos,
      super.height,
      super.width});
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPopup extends StatefulWidget {
  final Marker marker;
  final String text;
  const MapPopup(this.marker, {Key? key, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPopupState();
}

class _MapPopupState extends State<MapPopup> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _cardDescription(context),
        ],
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.text,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

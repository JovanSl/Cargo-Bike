import 'package:flutter/material.dart';

class SuggestedAddressListTile extends StatelessWidget {
  const SuggestedAddressListTile({
    Key? key,
    required this.street,
    required this.address,
    required this.streetName,
    required this.cityName,
    required this.stateName,
    required this.number,
  }) : super(key: key);

  final String street;
  final TextEditingController address;
  final String streetName;
  final String cityName;
  final String stateName;
  final String number;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (street == ' ') {
          address.text = streetName + ", " + cityName + ", " + stateName;
        } else {
          address.text =
              street + " " + number + ", " + cityName + ", " + stateName;
        }
      },
      child: ListTile(
        title: Text(
          street == ' '
              ? streetName + ", " + cityName + ", " + stateName
              : street + " " + number + ", " + cityName + ", " + stateName,
          maxLines: 3,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}

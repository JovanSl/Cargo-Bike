import 'package:flutter/material.dart';

import '../../../models/suggested_address.dart';
import 'address_suggestion_list_tile.dart';

class AddressSuggestionBuilder extends StatelessWidget {
  const AddressSuggestionBuilder({
    Key? key,
    required TextEditingController address,
    required this.suggestion,
  })  : _address = address,
        super(key: key);

  final TextEditingController _address;
  final List<Properties?> suggestion;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var streetName = suggestion[index]?.name ?? ' ';
          var cityName = suggestion[index]?.city ?? ' ';
          var stateName = suggestion[index]?.country ?? ' ';
          var street = suggestion[index]?.street ?? ' ';
          var number = suggestion[index]?.houseNumber ?? ' ';
          return SuggestedAddressListTile(
              street: street,
              address: _address,
              streetName: streetName,
              cityName: cityName,
              stateName: stateName,
              number: number);
        },
        itemCount: suggestion.length);
  }
}

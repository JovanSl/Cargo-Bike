import 'package:flutter/material.dart';

import '../../../models/delivery.dart';

class DeliveryListTile extends StatelessWidget {
  final Delivery delivery;
  const DeliveryListTile({Key? key, required this.delivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).secondaryHeaderColor,
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text(delivery.sender.name),
                    Text(delivery.sender.address),
                    Text(delivery.sender.phone),
                    Text(delivery.sender.email),
                  ],
                ),
              ),
              const Flexible(
                flex: 1,
                child: Center(
                    child: Icon(
                  Icons.east,
                  size: 50,
                )),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text(delivery.recipient.name),
                    Text(delivery.recipient.address),
                    Text(delivery.recipient.phone),
                    Text(delivery.recipient.additionalInfo),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

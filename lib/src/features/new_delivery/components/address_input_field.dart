import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/input_field_component.dart';
import '../../../models/recipient.dart';
import '../../../models/sender.dart';
import '../bloc/new_delivery_bloc.dart';

class AddressInput extends StatelessWidget {
  const AddressInput({
    Key? key,
    required TextEditingController recipientName,
    required TextEditingController recipientAddress,
    required TextEditingController recipientPhone,
    required TextEditingController additionalInfo,
    required TextEditingController senderName,
    required TextEditingController senderEmail,
    required TextEditingController senderPhone,
    required TextEditingController senderAddress,
    required TextEditingController streetnumber,
    required this.mainController,
    required this.lableStreetNumber,
    required this.lableAddress,
    required this.form,
  })  : _recipientName = recipientName,
        _recipientAddress = recipientAddress,
        _recipientPhone = recipientPhone,
        _additionalInfo = additionalInfo,
        _senderName = senderName,
        _senderEmail = senderEmail,
        _senderPhone = senderPhone,
        _senderAddress = senderAddress,
        _streetnumber = streetnumber,
        super(key: key);

  final TextEditingController mainController;
  final TextEditingController _recipientName;
  final TextEditingController _recipientAddress;
  final TextEditingController _recipientPhone;
  final TextEditingController _additionalInfo;
  final TextEditingController _senderName;
  final TextEditingController _senderEmail;
  final TextEditingController _senderPhone;
  final TextEditingController _senderAddress;
  final TextEditingController _streetnumber;
  final String lableStreetNumber;
  final String lableAddress;
  final String form;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: InputFieldComponent(
              paddingL: 40,
              paddingR: 10,
              onChanged: (value) {
                _checkUserInput(context);
              },
              controller: mainController,
              lable: lableAddress,
            ),
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.40),
            child: InputFieldComponent(
              paddingR: 40,
              paddingL: 10,
              controller: _streetnumber,
              lable: lableStreetNumber,
            ),
          )
        ],
      ),
    );
  }

  void _checkUserInput(BuildContext context) {
    context.read<NewDeliveryBloc>().add(CheckUserInputEvent(
        recipient: Recipient(
            name: _recipientName.text,
            address: _recipientAddress.text,
            phone: _recipientPhone.text,
            additionalInfo: _additionalInfo.text),
        sender: Sender(
            name: _senderName.text,
            email: _senderEmail.text,
            phone: _senderPhone.text,
            address: _senderAddress.text),
        null,
        null));
    context
        .read<NewDeliveryBloc>()
        .add(SuggestAddress(address: mainController.text, form: form));
  }
}

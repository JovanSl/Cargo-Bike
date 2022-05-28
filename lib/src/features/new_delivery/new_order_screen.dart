import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/models/recipient.dart';
import 'package:cargo_bike/src/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/new_delivery_bloc.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final TextEditingController _senderName = TextEditingController();
  final TextEditingController _senderEmail = TextEditingController();
  final TextEditingController _senderAddress = TextEditingController();
  final TextEditingController _senderPhone = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _recipientAddress = TextEditingController();
  final TextEditingController _recipientPhone = TextEditingController();
  final TextEditingController _additionalInfo = TextEditingController();
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Create delivery',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          foregroundColor: CargoBikeColors.lightGreen,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: CargoBikeColors.lightGreen),
            labelColor: Colors.black,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Text('Reception address'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Text('Delivery address'),
                ),
              ),
            ],
          ),
        ),
        body: BlocConsumer<NewDeliveryBloc, NewDeliveryState>(
          listener: (context, state) {
            if (state is AddDeliverySuccess) {
              Navigator.of(context).pop();
            }
            if (state is AddDeliveryError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Error ocured')));
            }
          },
          builder: (context, state) {
            if (state is NewDeliveryInitial || state is StateWithButton) {
              if (state is StateWithButton) {
                _isEnabled = true;
              }
              if (state is NewDeliveryInitial) {
                _isEnabled = false;
              }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    onChanged: () {
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
                              address: _senderAddress.text)));
                    },
                    child: TabBarView(children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            InputFieldComponent(
                              controller: _senderName,
                              lable: 'Name',
                            ),
                            InputFieldComponent(
                              controller: _senderEmail,
                              lable: 'Email Address',
                            ),
                            InputFieldComponent(
                              controller: _senderPhone,
                              lable: 'Phone number',
                            ),
                            InputFieldComponent(
                              controller: _senderAddress,
                              lable: 'Address',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          InputFieldComponent(
                            controller: _recipientName,
                            lable: 'Name',
                          ),
                          InputFieldComponent(
                            controller: _recipientAddress,
                            lable: 'Address',
                          ),
                          InputFieldComponent(
                            controller: _recipientPhone,
                            lable: 'Phone Number',
                          ),
                          InputFieldComponent(
                            controller: _additionalInfo,
                            lable: 'Additional info',
                          ),
                        ],
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          primary: CargoBikeColors.lightGreen,
                        ),
                        onPressed: _isEnabled
                            ? () {
                                context.read<NewDeliveryBloc>().add(
                                    AddDeliveryEvent(
                                        recipient: Recipient(
                                            name: _recipientName.text,
                                            address: _recipientAddress.text,
                                            phone: _recipientPhone.text,
                                            additionalInfo:
                                                _additionalInfo.text),
                                        sender: Sender(
                                            name: _senderName.text,
                                            email: _senderEmail.text,
                                            phone: _senderPhone.text,
                                            address: _senderAddress.text)));
                              }
                            : null,
                        child: const Text('Order')),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _senderName.dispose();
    _senderEmail.dispose();
    _senderAddress.dispose();
    _senderPhone.dispose();
    _recipientName.dispose();
    _recipientAddress.dispose();
    _recipientPhone.dispose();
    _additionalInfo.dispose();
    super.dispose();
  }
}

class InputFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  const InputFieldComponent({
    Key? key,
    required this.controller,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.lightGreen,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.only(left: 30, top: 24, bottom: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.lightGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: lable,
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

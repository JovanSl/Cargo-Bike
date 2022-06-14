import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/models/recipient.dart';
import 'package:cargo_bike/src/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/input_field_component.dart';
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
          title: Text(
            AppLocalizations.of(context)!.createDelivery,
            style: const TextStyle(color: Colors.black),
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
            tabs: [
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Text(AppLocalizations.of(context)!.receptionAddress),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Text(AppLocalizations.of(context)!.deliveryAddress),
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
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.error)));
            }
            if (state is BadAddressState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(AppLocalizations.of(context)!.errorLocationFormat)));
              context.read<NewDeliveryBloc>().add(SetDeliveryToInitial());
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
                              lable: AppLocalizations.of(context)!.name,
                            ),
                            InputFieldComponent(
                              controller: _senderEmail,
                              lable: AppLocalizations.of(context)!.emailAddress,
                            ),
                            InputFieldComponent(
                              controller: _senderPhone,
                              lable: AppLocalizations.of(context)!.phoneNumber,
                            ),
                            InputFieldComponent(
                              controller: _senderAddress,
                              lable: AppLocalizations.of(context)!
                                  .receptionAddress,
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
                            lable: AppLocalizations.of(context)!.name,
                          ),
                          InputFieldComponent(
                            controller: _recipientAddress,
                            lable:
                                AppLocalizations.of(context)!.deliveryAddress,
                          ),
                          InputFieldComponent(
                            controller: _recipientPhone,
                            lable: AppLocalizations.of(context)!.phoneNumber,
                          ),
                          InputFieldComponent(
                            controller: _additionalInfo,
                            lable: AppLocalizations.of(context)!.additionalInfo,
                          ),
                        ],
                      )
                    ]),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<NewDeliveryBloc>().add(
                            const SuggestAddress(
                                address: 'Devet jugovica novi sad'));
                      },
                      child: const Text("DUGME")),
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
                        child:
                            Text(AppLocalizations.of(context)!.createDelivery)),
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

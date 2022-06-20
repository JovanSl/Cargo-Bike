import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/models/recipient.dart';
import 'package:cargo_bike/src/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/input_field_component.dart';
import 'bloc/new_delivery_bloc.dart';
import 'components/address_card.dart';
import 'components/address_input_field.dart';
import 'components/address_suggestion_builder.dart';

class NewDeliveryScreen extends StatefulWidget {
  const NewDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<NewDeliveryScreen> createState() => _NewDeliveryScreenState();
}

class _NewDeliveryScreenState extends State<NewDeliveryScreen> {
  final TextEditingController _senderName = TextEditingController();
  final TextEditingController _senderEmail = TextEditingController();
  final TextEditingController _senderAddress = TextEditingController();
  final TextEditingController _senderPhone = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _recipientAddress = TextEditingController();
  final TextEditingController _recipientPhone = TextEditingController();
  final TextEditingController _additionalInfo = TextEditingController();
  final TextEditingController _recipientStreetnumber = TextEditingController();
  final TextEditingController _senderStreetnumber = TextEditingController();
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
            if (state is NewDeliveryInitial ||
                state is StateWithButton ||
                state is SuggestAddressState) {
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
                              additionalInfo: _additionalInfo.text,
                            ),
                            sender: Sender(
                              name: _senderName.text,
                              email: _senderEmail.text,
                              phone: _senderPhone.text,
                              address: _senderAddress.text,
                            ),
                            _recipientStreetnumber.text,
                            _senderStreetnumber.text,
                          ));
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
                            AddressInput(
                              mainController: _senderAddress,
                              recipientName: _recipientName,
                              recipientAddress: _recipientAddress,
                              recipientPhone: _recipientPhone,
                              additionalInfo: _additionalInfo,
                              senderName: _senderName,
                              senderEmail: _senderEmail,
                              senderPhone: _senderPhone,
                              senderAddress: _senderAddress,
                              streetnumber: _senderStreetnumber,
                              lableAddress: AppLocalizations.of(context)!
                                  .receptionAddress,
                              lableStreetNumber:
                                  AppLocalizations.of(context)!.streetNumber,
                              form: 'sender',
                            ),
                            if (state is SuggestAddressState)
                              if (state.form == 'sender')
                                SuggestionsCard(
                                    child: AddressSuggestionBuilder(
                                        address: _senderAddress,
                                        suggestion: state.suggestion)),
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
                            controller: _recipientPhone,
                            lable: AppLocalizations.of(context)!.phoneNumber,
                          ),
                          InputFieldComponent(
                            controller: _additionalInfo,
                            lable: AppLocalizations.of(context)!.additionalInfo,
                          ),
                          AddressInput(
                            mainController: _recipientAddress,
                            recipientName: _recipientName,
                            recipientAddress: _recipientAddress,
                            recipientPhone: _recipientPhone,
                            additionalInfo: _additionalInfo,
                            senderName: _senderName,
                            senderEmail: _senderEmail,
                            senderPhone: _senderPhone,
                            senderAddress: _senderAddress,
                            streetnumber: _recipientStreetnumber,
                            lableAddress:
                                AppLocalizations.of(context)!.deliveryAddress,
                            lableStreetNumber:
                                AppLocalizations.of(context)!.streetNumber,
                            form: 'receipant',
                          ),
                          if (state is SuggestAddressState)
                            if (state.form == 'receipant')
                              SuggestionsCard(
                                child: AddressSuggestionBuilder(
                                    address: _recipientAddress,
                                    suggestion: state.suggestion),
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
                                addDelivery(context);
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

  void addDelivery(BuildContext context) {
    context.read<NewDeliveryBloc>().add(AddDeliveryEvent(
          recipient: Recipient(
            name: _recipientName.text,
            address: _recipientAddress.text,
            phone: _recipientPhone.text,
            additionalInfo: _additionalInfo.text,
          ),
          sender: Sender(
            name: _senderName.text,
            email: _senderEmail.text,
            phone: _senderPhone.text,
            address: _senderAddress.text,
          ),
          _recipientStreetnumber.text,
          _senderStreetnumber.text,
        ));
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
    _recipientStreetnumber.dispose();
    _senderStreetnumber.dispose();
    super.dispose();
  }
}

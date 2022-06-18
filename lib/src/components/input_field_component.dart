import 'package:flutter/material.dart';

class InputFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  final Function(String)? onChanged;
  final double? paddingL;
  final double? paddingR;
  const InputFieldComponent({
    Key? key,
    required this.controller,
    required this.lable,
    this.onChanged,
    this.paddingL,
    this.paddingR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingL ?? 40, 10, paddingR ?? 40, 10),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller
          ..selection = TextSelection(
              baseOffset: controller.text.length,
              extentOffset: controller.text.length),
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

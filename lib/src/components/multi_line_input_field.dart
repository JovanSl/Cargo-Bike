import 'package:flutter/material.dart';

class MultiLineInputField extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  final Function(String)? onChanged;
  const MultiLineInputField({
    Key? key,
    required this.controller,
    required this.lable,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.multiline,
        minLines: 3,
        maxLines: 7,
        onChanged: onChanged,
        textInputAction: TextInputAction.newline,
        textAlign: TextAlign.start,
        controller: controller
        // ..selection = TextSelection(
        //     baseOffset: controller.text.length,
        //     extentOffset: controller.text.length),
        ,
        cursorColor: Colors.lightGreen,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.only(left: 13, top: 12, bottom: 16, right: 13),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.lightGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            labelText: lable,
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            alignLabelWithHint: true),
      ),
    );
  }
}

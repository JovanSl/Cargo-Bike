import 'package:flutter/material.dart';

class CargoBikeInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool hideText;

  const CargoBikeInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.hideText = false,
  }) : super(key: key);

  OutlineInputBorder _buildInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 45,
        right: 45,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).secondaryHeaderColor,
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 0,
              fontFamily: 'Montserrat',
              fontStyle: FontStyle.normal,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            focusedBorder: _buildInputBorder(),
            enabledBorder: _buildInputBorder(),
            contentPadding: const EdgeInsets.only(
              left: 20,
              top: 13,
              right: 20,
              bottom: 13,
            ),
          ),
          style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black
              // color: Theme.of(context).primaryColorDark,
              ),
          obscureText: hideText,
        ),
      ),
    );
  }
}

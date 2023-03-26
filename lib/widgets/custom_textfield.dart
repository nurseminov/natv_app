// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          labelText.toUpperCase(),
          style: const TextStyle(fontSize: 18, color: Color(0xFF808084)),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              border: const OutlineInputBorder()),
        )
      ]),
    );
  }
}

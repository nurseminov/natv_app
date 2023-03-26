// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({
    Key? key,
    required this.number,
    required this.description,
  }) : super(key: key);

  final String number;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF1F1F1),
              border: Border.all(color: const Color(0xFFC20937), width: 2)),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                  color: Color(0xFFC20937),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key});

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextField(
        controller: _phoneController,
        labelText: 'Контактный номер'.toUpperCase(),
        hintText: 'Пример: 0555123456',
        keyboardType: TextInputType.name,
      ),
      CustomTextField(
        controller: _emailController,
        labelText: 'E-mail'.toUpperCase(),
        hintText: 'primer@mail.com',
        keyboardType: TextInputType.name,
      ),
      CustomTextField(
        controller: _nameController,
        labelText: 'Укажите фамилию и имя'.toUpperCase(),
        hintText: 'Ф.И.О./ название организации',
        keyboardType: TextInputType.name,
      ),
    ]);
  }
}

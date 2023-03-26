import 'package:flutter/material.dart';

import 'custom_textbutton.dart';

Widget footerWidget() {
  return const Align(
    child: Column(
      children: [
        CustomTextbutton(text: 'О проекте'),
        CustomTextbutton(text: 'Способы оплаты'),
        CustomTextbutton(text: 'Для юридических лиц'),
        CustomTextbutton(text: 'Вопрос-ответ'),
        CustomTextbutton(text: 'Видеоинструкция по размещению'),
        CustomTextbutton(text: 'Договор публичной оферты'),
        CustomTextbutton(text: 'Правила заполнения текста'),
      ],
    ),
  );
}

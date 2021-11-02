// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

import 'preferences_item.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<Widget> _demo = [
    PreferencesItem(
      image: 'assets/food/cat.png',
      title: 'У меня есть кошка',
      isCheck: false,
    ),
    PreferencesItem(
      image: 'assets/food/dog.png',
      title: 'У меня есть собака',
      isCheck: false,
    ),
    PreferencesItem(
      image: 'assets/food/burgers.png',
      title: 'Я люблю поесть',
      isCheck: false,
    ),
    PreferencesItem(
      image: 'assets/food/apple.png',
      title: 'Я за ЗОЖ',
      isCheck: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: body(),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/logo/arrow_down.png',
                height: 20,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Готово',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        Text(
          'Предпочтения',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Добавьте ваши препдочтения в еде, аллергии и другие информации которые могут быть полезным для нас.',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w500, color: appGreyColor),
        ),
        SizedBox(
          height: 30.0,
        ),
        Column(
          children: _demo.toList(),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'С нас ништяки для вашего питомца, дайте нам знать если у вас они есть',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w500, color: appGreyColor),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SafeArea(
          child: body(),
        ),
      ),
      bottomNavigationBar: sendPassword(),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Восстановить пароль',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Введите новый пароль. Пороли должны совподать',
          style: TextStyle(
              color: appGreyColor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            //controller: nameController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Новый пароль',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            //controller: nameController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Повторите пароль',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget sendPassword() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        color: appBlackColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: 25,
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            'Отправить',
            style: TextStyle(
                color: appWhiteColor,
                fontSize: 16,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

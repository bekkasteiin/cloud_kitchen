// ignore_for_file: prefer_const_constructors

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final maskCpf = MaskTextInputFormatter(
      mask: "+7(000) 000-00-00", filter: {"0": RegExp(r'[0-9]')});

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
        bottomNavigationBar: getSMS());
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
        const SizedBox(
          height: 20.0,
        ),
        Text(
          'Введите номер телефона, На него придет код подтверждения',
          style: TextStyle(
              color: appGreyColor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
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
            keyboardType: TextInputType.phone,
            inputFormatters: [maskCpf],
            decoration: InputDecoration(
              hintText: '+7(000)000-00-00',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget getSMS() {
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
            Navigator.pushNamed(context, '/codePassword');
          },
          child: Text(
            'Получить код',
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

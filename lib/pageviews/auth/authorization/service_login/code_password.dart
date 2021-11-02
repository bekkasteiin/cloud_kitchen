// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodePassword extends StatefulWidget {
  const CodePassword({Key? key}) : super(key: key);

  @override
  _CodePasswordState createState() => _CodePasswordState();
}

class _CodePasswordState extends State<CodePassword> {
  var controller = TextEditingController();
  String currentText = "";

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
      bottomNavigationBar: sendSMS(),
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
          'Введите код из СМС',
          style: TextStyle(
              color: appGreyColor, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: PinCodeTextField(
            appContext: context,
            length: 4,
            obscureText: false,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 50,
                fieldWidth: 50),
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 300),
            controller: controller,
            keyboardType: TextInputType.number,
            // onTap: (value) {
            //   setState(() {
            //     currentText = value;
            //   });
            // },
            onChanged: (value) {
              setState(() {
                currentText = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget sendSMS() {
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
            Navigator.pushNamed(context, '/newPassword');
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

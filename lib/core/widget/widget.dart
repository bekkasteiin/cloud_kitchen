import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Container policyPDF() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Center(
      child: Text.rich(
        TextSpan(
          text: 'Соглашаюсь с ',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: appGreyColor),
          children: <TextSpan>[
            TextSpan(
                text: 'правилами пользования',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appGreyColor,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // code to open / launch terms of service link here
                  }),
            TextSpan(
              text: ' и ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appGreyColor),
              children: <TextSpan>[
                TextSpan(
                    text: 'пользовательским соглашнеием',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: appGreyColor,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // code to open / launch privacy policy link here
                      }),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

appBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CircleAvatar(
        maxRadius: 25,
        backgroundColor: appWhiteColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/profilePage');
          },
          child: Image.asset(
            'assets/logo/person.png',
            fit: BoxFit.fill,
            height: 35,
          ),
        ),
      ),
      CircleAvatar(
        maxRadius: 25,
        backgroundColor: appWhiteColor,
        child: InkWell(
          onTap: () {
            //Navigator.pushNamed(context, '/homePage');
          },
          child: Image.asset(
            'assets/logo/burger.png',
            fit: BoxFit.fill,
            height: 35,
          ),
        ),
      ),
      CircleAvatar(
        maxRadius: 25,
        backgroundColor: appWhiteColor,
        child: InkWell(
          onTap: () {},
          child: Image.asset(
            'assets/logo/msg.png',
            fit: BoxFit.fill,
            height: 35,
          ),
        ),
      ),
    ],
  );
}

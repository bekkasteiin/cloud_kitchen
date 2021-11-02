// ignore_for_file: prefer_const_constructors

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonusGetPage extends StatelessWidget {
  const BonusGetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: body(context),
        ),
      ),
      bottomNavigationBar: getButton(context),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/logo/arrow_down.png')),
        Text(
          'Бонусы',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Image.asset(
            'assets/logo/bonus.png',
            height: 150,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            '500₸',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Спасибо за вашу активность!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Мы ценим ваше время и дарим вам бонусы в размере 500₸ :)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget getButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        color: appBlackColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: 25,
          onPressed: () => dialog(context),
          child: Text(
            'Получить',
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

  dialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Text(
                'Поздравляем!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              content: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Color(0xff14D914),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Вы получили бонусы в размере 500₸',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0)),
                    color: appBlackColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 25,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Готово',
                        style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

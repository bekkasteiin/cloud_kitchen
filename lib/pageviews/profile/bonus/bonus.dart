// ignore_for_file: prefer_const_constructors

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                Text(
                  'Бонусы',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Бонусами можно оплатить заказы, тратить на покупки в специальном каталоге, у партнеров программы.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Накоплено:',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset('assets/logo/tg.png'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '500',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Если у вас есть промокод, вводите его и получайте бонусы к заказу!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          color: appBlackColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 25,
            onPressed: () {
              Navigator.pushNamed(context, '/bonusGetPage');
            },
            child: Text(
              'Ввести промокод',
              style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

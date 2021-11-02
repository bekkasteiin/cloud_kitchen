// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class PromoCodePage extends StatelessWidget {
  const PromoCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController promoCodeController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: body(promoCodeController, context),
          ),
        ),
      ),
      bottomNavigationBar: confirmButton(context),
    );
  }

  Widget body(dynamic promoCodeController, BuildContext context) {
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
        Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: appWhiteColor,
                    child: Image.asset(
                      'assets/food/fod1.png',
                      height: 35,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: appWhiteColor,
                    child: Image.asset(
                      'assets/food/cake.png',
                      height: 35.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: appWhiteColor,
                    child: Image.asset(
                      'assets/food/burgers.png',
                      height: 35,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: appWhiteColor,
                    child: Image.asset(
                      'assets/food/prize.png',
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: appWhiteColor,
                    child: Image.asset(
                      'assets/food/money.png',
                      height: 35.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: promoCodeController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Ввести промокод',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        Text(
          'Если у вас есть промокод Izzy, введите его чтобы получть бонусы.',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w500, color: appGreyColor),
        ),
      ],
    );
  }

  Widget confirmButton(BuildContext context) {
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
            //Navigator.pushNamed(context, '/regisPhone');
          },
          child: Text(
            'Подвердить',
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

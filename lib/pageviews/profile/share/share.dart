// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
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
        bottomNavigationBar: shareButton());
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
                icon: Image.asset('assets/logo/arrow_down.png')),
            InkWell(
                child: Text(
              'Готово',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )),
          ],
        ),
        Text(
          'Пригласи друга и получи бонусы',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Image.asset(
            'assets/logo/share.png',
            height: 200,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: [
            Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Text('1')),
            SizedBox(
              width: 20,
            ),
            Text(
              'Делитесь своим кодом с друзьями',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 45),
          width: MediaQuery.of(context).size.width / 1.3,
          child: Text(
            'Ваши друзья получат 500 ₸ в бонусах на каждый из первых 2 заказов на доставку, если введут ваш код при регистрации в CloudKitchen.',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: [
            Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Text('2')),
            SizedBox(
              width: 20,
            ),
            Text(
              'Получайте бонусы',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 45),
          width: MediaQuery.of(context).size.width / 1.3,
          child: Text(
            'Вы получите 800 ₸ в бонусах за каждый из 2 первых заказов на доставку.',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            width: 200,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0), color: Colors.grey),
            alignment: Alignment.center,
            child: Text(
              'G-23482',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  Widget shareButton() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        color: appBlackColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          height: 25,
          onPressed: () {
            Share.share('G-23482');
          },
          child: Text(
            'Поделиться кодом',
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

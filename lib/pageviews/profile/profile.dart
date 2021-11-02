// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_kitchen/core/provider/app_provider.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/core/utils/const.dart';
import 'package:cloud_kitchen/core/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                appBar(context),
                infoUser(),
                drawer(context),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoUser() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                'Арман Каримов',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              Text(
                _auth.currentUser?.phoneNumber ?? '',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/logo/profile.png"),
                ),
                Positioned(
                    bottom: -20,
                    right: -35,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Color(0xFFF5F6F9),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.all(5.0),
                      shape: CircleBorder(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(
            'Мои адреса',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, '/address');
          },
        ),
        ListTile(
          leading: Text(
            'Мои заказы',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, '/orders');
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            color: appBtnBlackColor,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/bonusPage');
              },
              leading: Text(
                'Бонусы',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: appWhiteColor),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        'assets/logo/bonus.png',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '500',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: appWhiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'Промокоды',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, '/promoCodePage');
          },
        ),
        ListTile(
          leading: Text(
            'Пригласить друга',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, '/share');
          },
        ),
        ListTile(
          leading: Text(
            'Push-уведомления',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Switch(
            value: isCheck,
            onChanged: (v) async {
              setState(() {
                isCheck = v;
              });
            },
            activeColor: Theme.of(context).accentColor,
          ),
          onTap: () {},
        ),
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? SizedBox()
            : ListTile(
                title: Text(
                  "Темный режим",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: Provider.of<AppProvider>(context).theme ==
                          Constants.lightTheme
                      ? false
                      : true,
                  onChanged: (v) async {
                    if (v) {
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(Constants.darkTheme, "dark");
                    } else {
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(Constants.lightTheme, "light");
                    }
                  },
                  activeColor: Theme.of(context).accentColor,
                ),
              ),
        ListTile(
          leading: Text(
            'Предпочтения',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, '/preferencesPage');
          },
        ),
        ListTile(
          leading: Text(
            'FAQ',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, '/faqPage');
          },
        ),
      ],
    );
  }
}

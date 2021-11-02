// ignore_for_file: prefer_const_constructors

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/core/widget/widget.dart';
import 'package:flutter/material.dart';

class ClocedKitchen extends StatefulWidget {
  const ClocedKitchen({Key? key}) : super(key: key);

  @override
  _ClocedKitchenState createState() => _ClocedKitchenState();
}

class _ClocedKitchenState extends State<ClocedKitchen> {
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
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Image.asset(
                      "assets/logo/moto.png",
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "18 мин",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "ул.Байзакова, 158",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: appWhiteGreyColor,
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 4.0),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/logo/closed.png",
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Кухня ещё не работает',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: appBlackColor),
                        ),
                        Text(
                          'Мы откроемся в 8:00 и снова сможем вас обслужить :)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: appGreyColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

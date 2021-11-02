// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:cloud_kitchen/core/model/product_model.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/pageviews/cart/cart_page_view.dart';
import 'package:flutter/material.dart';

class DetalisScreen extends StatefulWidget {
  dynamic title;
  dynamic price;
  dynamic image;
  DetalisScreen({Key? key, this.title, this.image, this.price})
      : super(key: key);

  @override
  _DetalisScreenState createState() => _DetalisScreenState();
}

class _DetalisScreenState extends State<DetalisScreen> {
  List<ProductList> shoppingList = [];
  List<dynamic> list = [
    {'qty': "1230", 'name': "ккал"},
    {'qty': "500", 'name': "грам"},
    {'qty': "42", 'name': "белка"},
    {'qty': "70", 'name': "жира"},
    {'qty': "98", 'name': "углеводы"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: body(),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          height: 250,
          child: Center(
            child: Image.asset(
              widget.image,
              height: 272,
              width: 272,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.title ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: appBlackColor),
              child: Text(
                '${widget.price} ₸',
                style: TextStyle(color: appWhiteColor),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: appGreyColor, width: 2)),
              child: Text(
                'халяль 🌙',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: appGreyColor, width: 2)),
              child: Text(
                'вегетарианское 🌱️',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: appGreyColor, width: 2)),
          child: Text(
            'острый 🌶️',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 0.5,
          color: appDarkBgColor.withOpacity(0.8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list.map((e) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  e['qty'],
                  style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  e['name'],
                  style: TextStyle(
                      color: Color(0xff111111).withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            );
          }).toList(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: 0.5,
          color: appDarkBgColor.withOpacity(0.8),
        ),
        Text(
          'Состав 🍕',
          style: TextStyle(
              color: Color(0xff111111),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "тесто, соус томатный, сыр моцарелла, помидоры, базилик зелёный, масло оливковое",
          style: TextStyle(
              color: Color(0xff111111).withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            setState(() {
              shoppingList.add(ProductList(
                  description: '',
                  image: widget.image,
                  name: widget.title,
                  price: widget.price,
                  duration: '7'));
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPageView(cart: shoppingList)));
          },
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xff43aa98),
                borderRadius: BorderRadius.circular(28.0),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Добавить в корзину',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: appWhiteColor),
                ),
              )),
        ),
      ],
    );
  }
}

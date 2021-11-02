// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/pageviews/food/detalis_page.dart';
import 'package:flutter/material.dart';

class BurgerItem extends StatelessWidget {
  dynamic image;
  dynamic title;
  dynamic price;

  BurgerItem({
    @required this.image,
    this.title = false,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetalisScreen(
                      title: title,
                      price: price,
                      image: image,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).accentColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                width: 125,
                height: 200,
              ),
            ),
            Column(
              children: [
                Wrap(
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: appWhiteColor),
                        child: Text(
                          '$price ₸',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.watch_later_outlined,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '+10 мин',
                      style: TextStyle(
                        color: Theme.of(context).unselectedWidgetColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

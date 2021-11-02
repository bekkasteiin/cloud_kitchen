// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/pageviews/food/detalis_page.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  dynamic image;
  dynamic title;
  dynamic price;

  ListItem({
    @required this.image,
    this.title = false,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
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
        child: Stack(
          children: [
            Image.asset(
              image,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: appWhiteColor),
                  child: IconButton(
                    icon: Image.asset('assets/food/pepper.png'),
                    onPressed: () {},
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: appWhiteColor),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.yellow),
                      child: Text(
                        '$price ₸',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: appBlackColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

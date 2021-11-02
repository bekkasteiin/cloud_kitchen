// ignore_for_file: prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class FaqItem extends StatefulWidget {
  dynamic title;
  dynamic description;
  FaqItem({Key? key, this.title, required this.description}) : super(key: key);

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detalis(
                            title: widget.title,
                            description: widget.description,
                          )));
            },
            trailing: Icon(Icons.arrow_forward_ios)),
        Divider()
      ],
    );
  }
}

class Detalis extends StatefulWidget {
  dynamic title;
  dynamic description;
  Detalis({Key? key, this.title, required this.description}) : super(key: key);

  @override
  State<Detalis> createState() => _DetalisState();
}

class _DetalisState extends State<Detalis> {
  bool change = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              faqQuetions(),
              SizedBox(height: 40.0),
              checkButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget faqQuetions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        Text(
          widget.title,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          widget.description,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget checkButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Был ли полезен этот ответ?',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  change = false;
                });
              },
              child: Container(
                width: 70,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: change ? appButtonGreyColor : Colors.yellow),
                child: Text(
                  'Да',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  change = true;
                });
              },
              child: Container(
                width: 70,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: change ? Colors.yellow : appButtonGreyColor),
                child: Text(
                  'Нет',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

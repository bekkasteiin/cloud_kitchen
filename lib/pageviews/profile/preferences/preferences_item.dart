// ignore_for_file: prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class PreferencesItem extends StatefulWidget {
  dynamic image;
  dynamic title;
  bool isCheck;
  PreferencesItem({Key? key, this.image, this.title, required this.isCheck})
      : super(key: key);

  @override
  _PreferencesItemState createState() => _PreferencesItemState();
}

class _PreferencesItemState extends State<PreferencesItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: appWhiteColor,
          child: Image.asset(
            widget.image,
            height: 25,
          )),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: widget.isCheck,
        onChanged: (v) async {
          setState(() {
            widget.isCheck = v;
          });
        },
        activeColor: appBlackColor,
      ),
    );
  }
}

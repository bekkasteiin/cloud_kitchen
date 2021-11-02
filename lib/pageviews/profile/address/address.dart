// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_location_map.dart';

class AddressPageView extends StatefulWidget {
  const AddressPageView({Key? key}) : super(key: key);

  @override
  _AddressPageViewState createState() => _AddressPageViewState();
}

class _AddressPageViewState extends State<AddressPageView> {
  TextEditingController addressController = TextEditingController();
  var listItems;

  FutureOr onGoBack(dynamic value) {
    getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onGoBack;
    setState(() {});
    getUser();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var itemData = prefs.getString('address');
    setState(() {
      listItems = itemData;
    });
  }

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
      bottomNavigationBar: addAddressButton(),
    );
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
            CircleAvatar(
              backgroundColor: Theme.of(context).unselectedWidgetColor,
              child: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
        Text(
          'Адреса',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 30),
        listItems != null
            ? ListTile(
                leading: Text(
                  listItems,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check_circle,
                      color: appDarkBgColor,
                    )),
              )
            : SizedBox(),
      ],
    );
  }

  Widget addAddressButton() {
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
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyLocationAddressMap()))
                .then(onGoBack);
          },
          child: Text(
            'Добавить адрес',
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

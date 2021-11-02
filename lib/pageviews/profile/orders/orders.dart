// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, deprecated_member_use

import 'package:cloud_kitchen/core/model/product_model.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

import 'animated_toggle.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  int _toggleValue = 0;

  List<ProductList> activeFood = [
    ProductList(
        description: '22.08.2021, 14:11',
        name: 'Паста с курицей,махито',
        image: '',
        duration: '',
        price: '2800 ₸'),
  ];

  List<ProductList> historyFood = [
    ProductList(
        description: '22.08.2021, 14:11',
        name: 'Паста с курицей,махито',
        image: '',
        duration: '',
        price: '2800 ₸'),
    ProductList(
        description: '18.08.2021, 16:07',
        name: 'Бургер, пицца, кола, махито',
        image: '',
        duration: '',
        price: '7300  ₸'),
    ProductList(
      description: '22.08.2021, 14:11',
      name: 'Лапша, пицца, лимонад...',
      price: '1360 ₸',
      image: '',
      duration: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                AnimatedToggle(
                    values: ['Активный заказ', 'История'],
                    onToggleCallback: (value) {
                      setState(() {
                        _toggleValue = value;
                      });
                    },
                    buttonColor: Theme.of(context).accentColor,
                    backgroundColor: Colors.grey,
                    textColor: appWhiteColor),
                SizedBox(
                  height: 30,
                ),
                _toggleValue == 0 ? activeOrder() : historyOrder()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget activeOrder() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: activeFood.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => CartPageView()));
                // },
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeFood[index].name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      activeFood[index].description,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      activeFood[index].price,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              Divider()
            ],
          );
        });
  }

  Widget historyOrder() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: historyFood.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/orderHistory');
                },
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      historyFood[index].name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      historyFood[index].description,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      historyFood[index].price,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              Divider()
            ],
          );
        });
  }
}

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, deprecated_member_use, use_key_in_widget_constructors, list_remove_unrelated_type, prefer_const_constructors_in_immutables

import 'package:cloud_kitchen/core/model/product_model.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class CartPageView extends StatefulWidget {
  final List<ProductList> cart;
  CartPageView({Key? key, required this.cart}) : super(key: key);

  @override
  _CartPageViewState createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  TextEditingController _comment = TextEditingController();
  bool isCheck = false;
  bool isChec = false;
  List<dynamic> appliances = [
    {"name": "Ложка", "image": "assets/food/v1.png", "qty": "4"},
    {"name": "Вилка", "image": "assets/food/v1.png", "qty": "2"},
    {"name": "Палочки", "image": "assets/food/v3.png", "qty": "+"}
  ];

  List<dynamic> additionOrder = [
    {"name": "Вода без газа", "image": "assets/food/water.png", "qty": "150 ₸"},
    {
      "name": "Газированная вода",
      "image": "assets/food/water.png",
      "qty": "200 ₸"
    }
  ];

  List<dynamic> specialistOrder = [
    {
      "name": "Паста с помидорами",
      "image": "assets/food/dop_food.png",
      "qty": "1500 ₸"
    },
    {
      "name": "Паста с помидорами",
      "image": "assets/food/dop_food.png",
      "qty": "2000 ₸"
    }
  ];

  @override
  void initState() {
    setState(() {});
    generateList();
    super.initState();
  }

  Widget generateList() {
    List<ProductList> list = widget.cart;
    ListView myList = ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      list[index].image,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            list[index].name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff111111)),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${list[index].price} ₸',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff111111)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('550 ккал')
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListTileItem(
                        list: list[index],
                        lists: list,
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ],
        );
      },
    );
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              header(),
              generateList(),
              body(),
              bottom(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/logo/arrow_down.png')),
        Text(
          'Доставка прибудет в течении 15 минут по адресу:',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'улица Жамбыла, 197к2',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            CircleAvatar(
              backgroundColor: appWhiteColor,
              child: Icon(
                Icons.edit_outlined,
                color: appGreyColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Комментарий к заказу',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: _comment,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Написать комментарий',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            leading: Text(
              'Доставить другому человеку',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
            ),
            trailing: Switch(
              value: isCheck,
              onChanged: (v) async {
                setState(() {
                  isCheck = v;
                });
                isCheck
                    ? showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.72,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Доставка другому человеку',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appWhiteGreyColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: TextFormField(
                                      controller: _comment,
                                      style: TextStyle(
                                          color: appBlackColor, fontSize: 16.0),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Имя',
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: appGreyColor),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appWhiteGreyColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: TextFormField(
                                      controller: _comment,
                                      style: TextStyle(
                                          color: appBlackColor, fontSize: 16.0),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Номер телефона',
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: appGreyColor),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        decoration: BoxDecoration(
                                          color: appWhiteGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: TextFormField(
                                          controller: _comment,
                                          style: TextStyle(
                                              color: appBlackColor,
                                              fontSize: 16.0),
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: 'Кв./офис',
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: appGreyColor),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        decoration: BoxDecoration(
                                          color: appWhiteGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: TextFormField(
                                          controller: _comment,
                                          style: TextStyle(
                                              color: appBlackColor,
                                              fontSize: 16.0),
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: 'Домофон',
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: appGreyColor),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        decoration: BoxDecoration(
                                          color: appWhiteGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: TextFormField(
                                          controller: _comment,
                                          style: TextStyle(
                                              color: appBlackColor,
                                              fontSize: 16.0),
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: 'Подъезд',
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: appGreyColor),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        decoration: BoxDecoration(
                                          color: appWhiteGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: TextFormField(
                                          controller: _comment,
                                          style: TextStyle(
                                              color: appBlackColor,
                                              fontSize: 16.0),
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: 'Этаж',
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: appGreyColor),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appWhiteGreyColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: TextFormField(
                                      controller: _comment,
                                      style: TextStyle(
                                          color: appBlackColor, fontSize: 16.0),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Комментарий к адресу',
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: appGreyColor),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28.0)),
                                    color: appButtonBlackColor,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      height: 25,
                                      onPressed: () {},
                                      child: Text(
                                        'Сохранить',
                                        style: TextStyle(
                                            color: appWhiteColor,
                                            fontSize: 16,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28.0)),
                                    color: appGreyColor,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      height: 25,
                                      onPressed: () {},
                                      child: Text(
                                        'Удалить',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : null;
              },
              activeColor: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Image.asset(
            'assets/food/cutlery.png',
            height: 32,
            width: 29,
          ),
          title: Text(
            'Приборы',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: Text(
            'Входят в ваш заказ',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff949494)),
          ),
        ),
        Divider(),
        SizedBox(
          height: 20,
        ),
        Text(
          'Дополнительные приборы',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 78,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            children: appliances.map((e) {
              return Container(
                height: 68,
                width: 105,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: appWhiteColor,
                  borderRadius: BorderRadius.circular(11.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            e['image'],
                            height: 30,
                          ),
                          Text(
                            e['name'],
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: appWhiteColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color(0xffe1e1e1), width: 0.5)),
                        child: Text(
                          e['qty'],
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff666666),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Text(
          'Дополнительно к заказу',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 82,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            children: additionOrder.map((e) {
              return Container(
                  height: 72,
                  width: 248,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    borderRadius: BorderRadius.circular(11.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      e['image'],
                      height: 35,
                    ),
                    title: Text(
                      e['name'],
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    trailing: Text(
                      e['qty'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ));
            }).toList(),
          ),
        ),
        Text(
          'Специальные предложения',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: 150,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            children: specialistOrder.map((e) {
              return Container(
                height: 140,
                width: 248,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: appWhiteColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(children: [
                  Image.asset(
                    e['image'],
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  e['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: appWhiteColor),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 78,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color(0xff9668CB)),
                            child: Text(
                              e['qty'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: appWhiteColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget bottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo/door.png',
              height: 30,
            ),
            Text(
              'Бесконтактная доставка',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cartInfo');
                },
                icon: Icon(Icons.info_outline)),
            Switch(
              value: isChec,
              onChanged: (v) async {
                setState(() {
                  isChec = v;
                });
              },
              activeColor: Theme.of(context).accentColor,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Способ оплаты',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff898989)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset('assets/logo/arrow_down.png')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Apple Pay',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111111)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/food/iPay.png',
                      height: 20,
                    )
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Color(0xff43AA98)),
              child: Text(
                '9075 ₸',
                style: TextStyle(color: appWhiteColor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            Navigator.pop(context);
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
                  'Заказать',
                  style: TextStyle(
                      color: appWhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )),
        ),
      ],
    );
  }
}

class ListTileItem extends StatefulWidget {
  final ProductList list;
  final List<ProductList> lists;
  ListTileItem({Key? key, required this.list, required this.lists})
      : super(key: key);
  @override
  _ListTileItemState createState() => _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 1;

  void deleted() {
    setState(() {
      widget.lists.removeWhere((element) => element.image == widget.list.image);
    });
  }

  @override
  void initState() {
    if (_itemCount == 0) {
      widget.lists.remove(widget.list);
    }
    deleted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _itemCount--;
            });
          },
          child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                  color: appWhiteColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.remove,
              )),
        ),
        SizedBox(
          width: 5,
        ),
        Text(_itemCount.toString(), style: TextStyle(fontSize: 14.0)),
        SizedBox(
          width: 5,
        ),
        InkWell(
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: appWhiteColor, borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.add),
          ),
          onTap: () => setState(() => _itemCount++),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_final_fields, prefer_const_constructors, sized_box_for_whitespace, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_is_empty, avoid_unnecessary_containers, await_only_futures, prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_kitchen/core/model/product_model.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/core/widget/widget.dart';
import 'package:cloud_kitchen/pageviews/cart/cart_page_view.dart';
import 'package:cloud_kitchen/pageviews/food/detalis_page.dart';
import 'package:cloud_kitchen/pageviews/home/list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'burger_item.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();
  CarouselController burgerCarouselController = CarouselController();
  CarouselController pizzaCarouselController = CarouselController();
  int pageIndex = 0;
  int burgerIndex = 0;
  int pizzaIndex = 0;
  List<ProductList> shoppingList = [];
  List<ProductList> hoodFood = [];
  List<ProductList> soupFood = [];
  var listItems;
  List<ProductList> firstHalf = [];
  List<ProductList> secondHalfSoup = [];
  bool flag = true;
  bool show = true;

  getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var itemData = prefs.getString('address');
    setState(() {
      listItems = itemData;
    });
  }

  void _populateDishes() {
    var list = <ProductList>[
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/foods1.png',
        price: '3500',
        duration: '5',
        description: '',
      ),
      ProductList(
        name: 'Омлет с грибами и колбаской',
        image: 'assets/food/foods2.png',
        price: '1500',
        duration: '3',
        description: '',
      ),
      ProductList(
        name: 'Семга на гриле',
        image: 'assets/food/foods3.png',
        price: '3000',
        description: '',
        duration: '10',
      ),
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/foods4.png',
        price: '2000',
        duration: '3',
        description: '',
      ),
      ProductList(
          name: 'Омлет с грибами и колбаской',
          image: 'assets/food/foods5.png',
          price: '2500',
          duration: '5',
          description: ''),
      ProductList(
          name: 'Семга на гриле',
          image: 'assets/food/foods6.png',
          price: '2000',
          duration: '7',
          description: ''),
    ];
    setState(() {
      hoodFood = list;
    });
  }

  void _populateSoupSecond() {
    var list = <ProductList>[
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/sup1.png',
        price: '3000',
        description: '',
        duration: '10',
      ),
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/sup2.png',
        price: '2000',
        duration: '3',
        description: '',
      ),
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/sup3.png',
        price: '3000',
        description: '',
        duration: '10',
      ),
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/sup4.png',
        price: '2000',
        duration: '3',
        description: '',
      ),
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/sup4.png',
        price: '3000',
        description: '',
        duration: '10',
      ),
      ProductList(
        name: 'Судак на грилле в чесночном соусе',
        image: 'assets/food/sup5.png',
        price: '2000',
        duration: '3',
        description: '',
      ),
    ];
    setState(() {
      soupFood = list;
    });
  }

  List<Widget> _demo = [
    ListItem(
      image: 'assets/food/main.png',
      title: 'Бургеры с катлетой и беконом по скидке 50%',
      price: '570',
    ),
    ListItem(
      image: 'assets/food/main.png',
      title: 'Бургеры с катлетой и беконом по скидке 50%',
      price: '570',
    ),
    ListItem(
      image: 'assets/food/main.png',
      title: 'Бургеры с катлетой и беконом по скидке 50%',
      price: '570',
    ),
    ListItem(
      image: 'assets/food/main.png',
      title: 'Бургеры с катлетой и беконом по скидке 50%',
      price: '570',
    ),
  ];

  List<Widget> _burger = [
    BurgerItem(
      image: 'assets/food/burger_food.png',
      title: 'Бургер BBQ комбо',
      price: '1250',
    ),
    BurgerItem(
      image: 'assets/food/burger_food.png',
      title: 'Бургер BBQ комбо',
      price: '1250',
    ),
    BurgerItem(
      image: 'assets/food/burger_food.png',
      title: 'Бургер BBQ комбо',
      price: '1250',
    ),
    BurgerItem(
      image: 'assets/food/burger_food.png',
      title: 'Бургер BBQ комбо',
      price: '1250',
    ),
  ];

  List<Widget> _pizza = [
    BurgerItem(
      image: 'assets/food/pizza.png',
      title: 'Пицаа “Маргарита”',
      price: '1250',
    ),
    BurgerItem(
      image: 'assets/food/pizza.png',
      title: 'Пицаа “Маргарита”',
      price: '1250',
    ),
    BurgerItem(
      image: 'assets/food/pizza.png',
      title: 'Пицаа “Маргарита”',
      price: '1250',
    ),
    BurgerItem(
      image: 'assets/food/pizza.png',
      title: 'Пицаа “Маргарита”',
      price: '1250',
    ),
  ];

  @override
  void initState() {
    getUser();
    _populateDishes();
    _populateSoupSecond();
    getAddress();
    if (hoodFood.length > 2) {
      firstHalf = hoodFood.sublist(0, 2);
    } else {
      firstHalf = hoodFood;
    }
    if (soupFood.length > 2) {
      secondHalfSoup = soupFood.sublist(0, 2);
    } else {
      secondHalfSoup = hoodFood;
    }
    super.initState();
  }

  added(var item) {
    setState(() {
      shoppingList.add(item);
    });
  }

  Future getUser() async {
    if (_auth.currentUser != null) {
      var cellNumber = _auth.currentUser!.phoneNumber;
      cellNumber = '0' +
          _auth.currentUser!.phoneNumber!.substring(3, cellNumber!.length);
      debugPrint(cellNumber);
      await _firestore
          .collection('users')
          .where('cellnumber', isEqualTo: cellNumber)
          .get()
          .then((result) {
        if (result.docs.length > 0) {
          setState(() {
            userName = result.docs[0].data()['address'];
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context),
                header(),
                coruselBurger(),
                Text(
                  'Горячие блюда',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                hotFood(),
                burgers(),
                secondFood(),
                pizzaCorusel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CartPageView(
                  cart: shoppingList,
                ),
              ),
            );
          },
          icon: Icon(Icons.shopping_basket_sharp),
        ),
        Row(
          children: [
            Image.asset(
              "assets/logo/moto.png",
              height: 35,
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
                  fontSize: 18),
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              listItems ?? '',
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
          height: 20.0,
        ),
        Text(
          'Для вас',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget coruselBurger() {
    return Column(
      children: [
        SizedBox(height: 20.0),
        CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 2,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  burgerIndex = index;
                });
              },
              autoPlay: true,
            ),
            items: _demo),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _demo.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => buttonCarouselController.animateToPage(entry.key),
              child: Container(
                width: MediaQuery.of(context).size.width / 5.5,
                height: 2.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(burgerIndex == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget hotFood() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalisScreen(
                          title: 'Семга с зеленью на гриле',
                          price: '2500',
                          image: 'assets/logo/food1.png',
                        )));
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xffEACEB7),
                        const Color(0xffD0967E),
                      ],
                    )),
              ),
              Column(
                children: [
                  Center(
                    child: Image.asset('assets/logo/food1.png'),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        color: appWhiteColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: [
                            Container(
                              width: 180,
                              child: Text(
                                'Семга с зеленью на гриле',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                width: 100,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black),
                                child: Text(
                                  '2500 ₸',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: appDarkBgColor,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '+7 мин',
                                  style: TextStyle(
                                      color: appDarkBgColor,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: flag ? firstHalf.length : hoodFood.length,
              itemBuilder: (context, index) {
                var item = flag ? firstHalf[index] : hoodFood[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    IconSlideAction(
                        caption: '+',
                        color: Colors.yellow,
                        icon: Icons.card_giftcard,
                        onTap: () async {
                          await added(item);
                          await ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_bag,
                                      color: appWhiteColor,
                                    ),
                                    Text('Корзина'),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      item.image,
                                      width: 40,
                                      height: 40,
                                    )
                                  ],
                                ),
                                Text('+20min'),
                                Text('5000ng')
                              ],
                            ),
                          ));
                        }),
                  ],
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetalisScreen(
                                        title: item.name,
                                        price: item.price,
                                        image: item.image,
                                      )));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.fill,
                                  width: 100,
                                ),
                              ),
                              Column(
                                children: [
                                  Wrap(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: appDarkBgColor,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '+${item.duration} мин',
                                        style: TextStyle(
                                            color: appDarkBgColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: appWhiteColor),
                                          child: Text(
                                            '${item.price} ₸',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).unselectedWidgetColor,
                                    radius: 15,
                                    child: Image.asset(
                                      'assets/food/pepper.png',
                                      height: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).unselectedWidgetColor,
                                    radius: 15,
                                    child: Image.asset(
                                      'assets/food/ll.png',
                                      height: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
            InkWell(
              child: Text(flag ? 'Показать еще' : 'Скрыть'),
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget secondFood() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalisScreen(
                          title: 'Суп с моцареллой',
                          price: '1150',
                          image: 'assets/food/suup.png',
                        )));
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xffEACEB7),
                        const Color(0xffD0967E),
                      ],
                    )),
              ),
              Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/food/suup.png',
                      height: 200,
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        color: appWhiteColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: [
                            Container(
                              width: 180,
                              child: Text(
                                'Суп с моцареллой',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: appBlackColor),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                width: 100,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black),
                                child: Text(
                                  '1150 ₸',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: appDarkBgColor,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '+7 мин',
                                  style: TextStyle(
                                      color: appDarkBgColor,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: show ? secondHalfSoup.length : soupFood.length,
              itemBuilder: (context, index) {
                var item = show ? secondHalfSoup[index] : soupFood[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    IconSlideAction(
                        caption: '+',
                        color: Colors.yellow,
                        icon: Icons.card_giftcard,
                        onTap: () async {
                          await added(item);
                          await ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_bag,
                                      color: appWhiteColor,
                                    ),
                                    Text('Корзина'),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      item.image,
                                      width: 40,
                                      height: 40,
                                    )
                                  ],
                                ),
                                Text('+20min'),
                                Text('5000ng')
                              ],
                            ),
                          ));
                        }),
                  ],
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetalisScreen(
                                        title: item.name,
                                        price: item.price,
                                        image: item.image,
                                      )));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.fill,
                                  width: 100,
                                ),
                              ),
                              Column(
                                children: [
                                  Wrap(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: appDarkBgColor,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '+${item.duration} мин',
                                        style: TextStyle(
                                            color: appDarkBgColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: appWhiteColor),
                                          child: Text(
                                            '${item.price} ₸',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).unselectedWidgetColor,
                                    radius: 15,
                                    child: Image.asset(
                                      'assets/food/pepper.png',
                                      height: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).unselectedWidgetColor,
                                    radius: 15,
                                    child: Image.asset(
                                      'assets/food/ll.png',
                                      height: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
            InkWell(
              child: Text(show ? 'Показать еще' : 'Скрыть'),
              onTap: () {
                setState(() {
                  show = !show;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget burgers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Бургеры',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20.0,
        ),
        CarouselSlider(
            carouselController: burgerCarouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 5,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  pageIndex = index;
                });
              },
              // autoPlay: false,
            ),
            items: _burger),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _burger.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => burgerCarouselController.animateToPage(entry.key),
              child: Container(
                width: MediaQuery.of(context).size.width / 5.5,
                height: 2.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(pageIndex == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Супы',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget pizzaCorusel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Пицца',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20.0,
        ),
        CarouselSlider(
            carouselController: pizzaCarouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 5,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  pageIndex = index;
                });
              },
              autoPlay: true,
            ),
            items: _pizza),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _pizza.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => pizzaCarouselController.animateToPage(entry.key),
              child: Container(
                width: MediaQuery.of(context).size.width / 5.5,
                height: 2.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(pageIndex == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class CartInfoDelivery extends StatelessWidget {
  const CartInfoDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: body(context),
          ),
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/logo/arrow_down.png')),
        Text(
          'Бесконтактная доставка',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                'Вам придёт пуш, когда ваш заказ будет стоять около двери, а райдер сразу отправится на новый заказ.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Image.asset(
              'assets/logo/door_order.png',
              height: 100,
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Какие ещё меры мы предпринимаем?',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: Image.asset(
            'assets/logo/temp.png',
          ),
          title: Text(
            'Каждое утро измеряем температуру у всех сотрудников.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: Image.asset('assets/logo/anti.png'),
          title: Text(
            'Все райдеры перед заказом обрабатывают руки санитайзером и носят перчатки.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: Image.asset('assets/logo/qr.png'),
          title: Text(
            'Не контактируем с наличкой - у нас только онлайн-оплата.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: Image.asset('assets/logo/bag.png'),
          title: Text(
            'Райдеры отдают заказ не в руки, а оставляют на сумке.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: Image.asset('assets/logo/hassp.png'),
          title: Text(
            'Все кухни работают с особым вниманием по нормам ХАССП.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'С любовью, Cloud Kitchen 💛',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

import 'faq_item.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _demo = [
      FaqItem(
        title: 'Сколько стоит доставка?',
        description:
            'Стоимость наших услуг зависит от расстояния - чем меньше расстояние преодолевают наши курьеры, тем ниже стоимость доставки.',
      ),
      FaqItem(
        title: 'Когда вы работаете?',
        description:
            'Стоимость наших услуг зависит от расстояния - чем меньше расстояние преодолевают наши курьеры, тем ниже стоимость доставки.',
      ),
      FaqItem(
        title: 'Оплата не прошла',
        description:
            'В профиле есть раздел “промокоды” , введите код, активируйте его и получите скидку к заказу.',
      ),
      FaqItem(
        title: 'Как воспользоваться промокодом?',
        description:
            'В профиле есть раздел “промокоды” , введите код, активируйте его и получите скидку к заказу.',
      ),
      FaqItem(
        title: 'Когда мне доставят заказ?',
        description:
            'Стоимость наших услуг зависит от расстояния - чем меньше расстояние преодолевают наши курьеры, тем ниже стоимость доставки',
      ),
      FaqItem(
        title: 'Как разместить заказ?',
        description:
            'В профиле есть раздел “промокоды” , введите код, активируйте его и получите скидку к заказу.',
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: body(context, _demo),
          ),
        ),
      ),
      floatingActionButton: appreciateButton(context),
    );
  }

  Widget body(BuildContext context, dynamic demo) {
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
              icon: Image.asset(
                'assets/logo/arrow_down.png',
                height: 20,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Готово',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        Text(
          'Часто задаваемые вопросы',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: demo.toList(),
        )
      ],
    );
  }

  Widget appreciateButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Адрес офиса: Кульджинский тракт, 6/7',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xffB5B5B5))),
          Container(
            margin: EdgeInsets.all(5.0),
            height: 1,
            color: appBlackColor,
          ),
          Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0)),
            color: appBlackColor,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 25,
              onPressed: () {
                //Navigator.pushNamed(context, '/promoCodePage');
              },
              child: Text(
                'Оценить приложения',
                style: TextStyle(
                    color: appWhiteColor,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

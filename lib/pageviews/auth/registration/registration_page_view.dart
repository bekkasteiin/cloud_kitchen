// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_element, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/core/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'registration.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegistrationPageView extends StatefulWidget {
  const RegistrationPageView({Key? key}) : super(key: key);

  @override
  _RegistrationPageViewState createState() => _RegistrationPageViewState();
}

class _RegistrationPageViewState extends State<RegistrationPageView> {
  final int _numPages = 3;
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final maskCpf = MaskTextInputFormatter(
      mask: "0000000000", filter: {"0": RegExp(r'[0-9]')});
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 10.0,
      width: isActive ? 40.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              appBarPop(),
              circleNextPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarPop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              _currentPage == 0
                  ? Navigator.pop(context)
                  : _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
            },
            icon: Icon(Icons.arrow_back)),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Не сейчас',
            style: TextStyle(
              color: appBlackColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget circleNextPage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height,
      child: PageView(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          writeName(),
          writePhone(),
          //writePassword()
        ],
      ),
    );
  }

  Widget writeName() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Регистрация',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Введите Ваше имя',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: nameController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Имя',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        policyPDF(),
        Center(
          child: Image.asset(
            'assets/logo/registr.png',
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        SizedBox(
          height: 30,
        ),
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          color: appBlackColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 25,
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: Text(
              'Далее',
              style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget writePhone() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Регистрация',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Введите номер телефона',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: phoneController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            inputFormatters: [maskCpf],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Номер телефона',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        policyPDF(),
        Center(
          child: Image.asset('assets/logo/phone.png'),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        SizedBox(
          height: 30,
        ),
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          color: appBlackColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 25,
            onPressed: () {
              // _pageController.nextPage(
              //   duration: Duration(milliseconds: 500),
              //   curve: Curves.ease,
              // );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationPage(
                            nameController: nameController,
                            phoneController: phoneController,
                          )));
            },
            child: Text(
              'Далее',
              style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget writePassword() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Регистрация',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Придумайте пароль',
            style: TextStyle(
                color: appBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: passwordController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Пароль',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        policyPDF(),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Image.asset(
            'assets/logo/password.png',
            height: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        SizedBox(
          height: 30,
        ),
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          color: appBlackColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 25,
            onPressed: () {
              Navigator.pushNamed(context, '/registration');
            },
            child: Text(
              'Зарегистрироваться',
              style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

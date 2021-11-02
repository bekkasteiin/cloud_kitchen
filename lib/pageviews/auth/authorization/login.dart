// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use, prefer_is_empty, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, invalid_return_type_for_catch_error, avoid_unnecessary_containers, unused_field

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/core/utils/helpers.dart';
import 'package:cloud_kitchen/core/utils/user.dart' as user;
import 'package:cloud_kitchen/pageviews/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = false;
  var isResend = false;
  var isLoginScreen = true;
  var isOTPScreen = false;
  var verificationCode = '';

  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  final maskCpf = MaskTextInputFormatter(
      mask: "+7(000) 000-00-00", filter: {"0": RegExp(r'[0-9]')});

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : returnLoginScreen();
  }

  Widget returnLoginScreen() {
    return WillPopScope(
      onWillPop: () async => exit(0),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Не сейчас',
                    style: TextStyle(
                      color: appGreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Войти',
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
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: appWhiteGreyColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    style: TextStyle(color: appBlackColor, fontSize: 16.0),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.phone,
                    // inputFormatters: [maskCpf],
                    decoration: InputDecoration(
                      hintText: 'Номер телефона',
                      hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 10.0),
                //   decoration: BoxDecoration(
                //     color: appWhiteGreyColor,
                //     borderRadius: BorderRadius.circular(12.0),
                //   ),
                //   child: TextFormField(
                //     controller: passwordController,
                //     style: TextStyle(color: appBlackColor, fontSize: 16.0),
                //     cursorColor: Colors.black,
                //     keyboardType: TextInputType.text,
                //     obscureText: true,
                //     decoration: InputDecoration(
                //       hintText: 'Пароль',
                //       hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
                //       border: InputBorder.none,
                //       contentPadding: const EdgeInsets.all(16),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                        color: appBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              !isLoading
                  ? Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0)),
                      color: appBlackColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 25,
                        onPressed: () async {
                          if (!isLoading) {
                            displaySnackBar('Please wait...');
                            await login();
                          }
                          // if ((timeNow > 8) && (timeNow < 23)) {
                          //   Navigator.pushNamed(context, '/homePage');
                          // } else {
                          //   Navigator.pushNamed(context, '/closedKitchen');
                          // }
                        },
                        child: Text(
                          'Войти',
                          style: TextStyle(
                              color: appWhiteColor,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
              SizedBox(
                height: 20,
              ),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0)),
                color: appGreyColor,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 25,
                  onPressed: () {
                    Navigator.pushNamed(context, '/regisPage');
                  },
                  child: Text(
                    'Регистрация',
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
        ),
      ),
    );
  }

  Widget returnOTPScreen() {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Form(
            key: _formKeyOTP,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset('assets/logo/arrow_down.png')),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                              !isLoading
                                  ? "Введите OTP из SMS"
                                  : "Отправка SMS с кодом OTP",
                              textAlign: TextAlign.center))),
                  !isLoading
                      ? Container(
                          decoration: BoxDecoration(
                            color: appGreyColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            enabled: !isLoading,
                            controller: passwordController,
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: appWhiteColor, fontSize: 24),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            !isLoading
                ? Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0)),
                    color: appGreyColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 25,
                      onPressed: () async {
                        setState(() {
                          isResend = false;
                          isLoading = true;
                        });

                        try {
                          await _auth
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationCode,
                                      smsCode:
                                          passwordController.text.toString()))
                              .then((users) async => {
                                    //sign in was success
                                    if (users != null)
                                      {
                                        setState(() {
                                          isLoading = false;
                                          isResend = false;
                                        }),
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(),
                                          ),
                                          (route) => false,
                                        )
                                      }
                                  })
                              .catchError((error) => {
                                    setState(() {
                                      isLoading = false;
                                      isResend = true;
                                    }),
                                  });
                          setState(() {
                            isLoading = true;
                          });
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        //  }
                      },
                      child: Text(
                        'Войти',
                        style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            )
                          ].where((c) => c != null).toList(),
                        )
                      ]),
            isResend
                ? Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0)),
                    color: appGreyColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 25,
                      onPressed: () async {
                        setState(() {
                          isResend = false;
                          isLoading = true;
                        });
                        await login();
                      },
                      child: Text(
                        'Отправить код повторно',
                        style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  displaySnackBar(text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  Future login() async {
    setState(() {
      isLoading = true;
    });
    var phoneNumber = '+7 ' + nameController.text.trim();
    var isValidUser = false;
    var number = nameController.text.trim();

    await _firestore
        .collection('users')
        .where('cellnumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
        SharedPreferencesHelper.setString('token', userName);
        user.token = result.docs[0].data()['name'];
      }
    });

    if (isValidUser) {
      var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          _auth
              .signInWithCredential(phoneAuthCredential)
              .then((users) async => {
                    if (users != null)
                      {
                        setState(() {
                          isLoading = false;
                          isOTPScreen = false;
                        }),
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(),
                          ),
                          (route) => false,
                        )
                      }
                  });
        },
        verificationFailed: (FirebaseAuthException error) {
          displaySnackBar('Validation error, please try again later');
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
            isOTPScreen = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
      await verifyPhoneNumber;
    } else {
      //non valid user
      setState(() {
        isLoading = false;
      });
      displaySnackBar('Number not found, please sign up first');
    }
  }
}

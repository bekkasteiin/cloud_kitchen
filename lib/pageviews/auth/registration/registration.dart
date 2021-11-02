// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, unnecessary_new, invalid_return_type_for_catch_error, unnecessary_null_comparison, unused_field, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/core/widget/widget.dart';
import 'package:cloud_kitchen/pageviews/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegistrationPage extends StatefulWidget {
  var phoneController;
  var nameController;
  RegistrationPage({Key? key, this.phoneController, this.nameController})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final maskCpf = MaskTextInputFormatter(
      mask: "0000000000", filter: {"0": RegExp(r'[0-9]')});

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    // nameController.dispose();
    // phoneController.dispose();
    //passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : registerScreen();
  }

  Widget registerScreen() {
    final node = FocusScope.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appWhiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(child: writeData()),
        ),
      ),
      bottomNavigationBar: nextButton(),
    );
  }

  Widget returnOTPScreen() {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(children: [
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
                          style: TextStyle(color: appWhiteColor, fontSize: 24),
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
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
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
                              .then((user) async => {
                                    //sign in was success
                                    if (user != null)
                                      {
                                        //store registration details in firestore database
                                        await _firestore
                                            .collection('users')
                                            .doc(_auth.currentUser?.uid)
                                            .set({
                                          'name':
                                              widget.nameController.text.trim(),
                                          'cellnumber': widget
                                              .phoneController.text
                                              .trim(),
                                        }, SetOptions(merge: true)).then(
                                                (value) => {
                                                      //then move to authorised area
                                                      setState(() {
                                                        isLoading = false;
                                                        isResend = false;
                                                      })
                                                    }),

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
                        await signUp();
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

  Widget writeData() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
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
        ),
        SizedBox(
          height: 20,
        ),
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
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: widget.nameController,
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: appWhiteGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: widget.phoneController,
            style: TextStyle(color: appBlackColor, fontSize: 16.0),
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            inputFormatters: [maskCpf],
            decoration: InputDecoration(
              hintText: 'Номер телефона',
              hintStyle: TextStyle(fontSize: 16, color: appGreyColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(vertical: 20.0),
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
        policyPDF(),
      ],
    );
  }

  Widget nextButton() {
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
            if (!isLoading) {
              setState(() {
                signUp();
                isRegister = false;
                isOTPScreen = true;
              });
            }
            // Navigator.pushNamed(context, '/homePage');
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
      ),
    );
  }

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    var phoneNumber = '+7 ' + widget.phoneController.text.toString();
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
              if (user != null)
                {
                  await _firestore
                      .collection('users')
                      .doc(_auth.currentUser?.uid)
                      .set({
                        'name': widget.nameController.text.trim(),
                        'cellnumber': widget.phoneController.text.trim()
                      }, SetOptions(merge: true))
                      .then((value) => {
                            setState(() {
                              isLoading = false;
                              isRegister = false;
                              isOTPScreen = false;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(),
                                ),
                                (route) => false,
                              );
                            })
                          })
                      .catchError((onError) => {
                            debugPrint(
                                'Error saving user to db.' + onError.toString())
                          })
                }
            });
      },
      verificationFailed: (FirebaseAuthException error) {
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, [forceResendingToken]) {
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
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
  }
}

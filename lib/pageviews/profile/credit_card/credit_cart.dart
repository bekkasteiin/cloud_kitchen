// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_local_variable, unused_element, unnecessary_new, constant_identifier_names, unused_field, prefer_final_fields, unnecessary_this

import 'dart:io';

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:cloud_kitchen/pageviews/profile/credit_card/my_card.dart';
import 'package:cloud_kitchen/pageviews/profile/credit_card/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'input.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var _paymentCard = PaymentCard();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  final maskCpf = MaskTextInputFormatter(
      mask: "0000 0000 0000 0000", filter: {"0": RegExp(r'[0-9]')});
  final dateCpf =
      MaskTextInputFormatter(mask: "00/00", filter: {"0": RegExp(r'[0-9]')});
  final cvCpf =
      MaskTextInputFormatter(mask: "000", filter: {"0": RegExp(r'[0-9]')});
  var _card = new PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  void dispose() {
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/logo/arrow_down.png')),
                Text(
                  'Карта для оплаты',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color(0xFF4F4F4F)),
                        child: TextFormField(
                          controller: numberController,
                          style: TextStyle(
                              color: Theme.of(context).unselectedWidgetColor,
                              fontSize: 16.0),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberInputFormatter()
                          ],
                          decoration: InputDecoration(
                            suffixIcon:
                                CardUtils.getCardIcon(_paymentCard.type),
                            border: InputBorder.none,
                          ),
                          onSaved: (String? value) {
                            _paymentCard.number =
                                CardUtils.getCleanedNumber(value!);
                          },
                          validator: CardUtils.validateCardNum,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Color(0xFF4F4F4F)),
                            child: TextFormField(
                              controller: dateController,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                  fontSize: 16.0),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [dateCpf],
                              decoration: InputDecoration(
                                hintText: '00/00',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Color(0xFF4F4F4F)),
                            child: TextFormField(
                              controller: cvController,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                  fontSize: 16.0),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [cvCpf],
                              decoration: InputDecoration(
                                hintText: '000',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
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
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color(0xFF4F4F4F)),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: nameController,
                          style: TextStyle(
                              color: Theme.of(context).unselectedWidgetColor,
                              fontSize: 16.0),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Имя Фамилия',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).unselectedWidgetColor),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Image.asset(
                    'assets/logo/pay.png',
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  color: appBlackColor,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 25,
                    onPressed: () {},
                    child: Text(
                      'Добавить',
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
      ),
    );
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      _showInSnackBar('Payment card is valid');
    }
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: Text(
          Strings.pay,
          style: TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return new ElevatedButton(
        onPressed: _validateInputs,
        child: new Text(
          Strings.pay.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }
}

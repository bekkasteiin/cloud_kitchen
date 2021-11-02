// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_const_constructors

import 'package:cloud_kitchen/pageviews/auth/authorization/login.dart';
import 'package:cloud_kitchen/pageviews/close/close.dart';
import 'package:cloud_kitchen/pageviews/home/home_page.dart';
import 'package:cloud_kitchen/pageviews/profile/address/address.dart';
import 'package:cloud_kitchen/pageviews/profile/credit_card/credit_cart.dart';
import 'package:cloud_kitchen/pageviews/profile/profile.dart';
import 'package:cloud_kitchen/pageviews/profile/promo_code/promo_code.dart';
import 'package:cloud_kitchen/pageviews/profile/share/share.dart';
import 'package:cloud_kitchen/pageviews/splash_page/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'core/provider/app_provider.dart';
import 'core/utils/const.dart';
import 'pageviews/auth/authorization/service_login/code_password.dart';
import 'pageviews/auth/authorization/service_login/forgot_password.dart';
import 'pageviews/auth/authorization/service_login/new_password.dart';
import 'pageviews/auth/registration/registration_page_view.dart';
import 'pageviews/cart/info_delivery.dart';
import 'pageviews/profile/bonus/bonus.dart';
import 'pageviews/profile/bonus/bonus_get.dart';
import 'pageviews/profile/faq/faq.dart';
import 'pageviews/profile/orders/order_history.dart';
import 'pageviews/profile/orders/orders.dart';
import 'pageviews/profile/preferences/preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load app'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<AppProvider>(
              builder: (BuildContext context, AppProvider appProvider, _) {
                return MaterialApp(
                  key: appProvider.key,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: appProvider.navigatorKey,
                  title: Constants.appName,
                  theme: appProvider.theme,
                  darkTheme: Constants.darkTheme,
                  home: SplashScreen(),
                  routes: {
                    '/login': (context) => const LoginPage(),
                    '/forgotPassword': (context) => const ForgotPassword(),
                    '/codePassword': (context) => const CodePassword(),
                    '/newPassword': (context) => const NewPassword(),
                    '/closedKitchen': (context) => const ClocedKitchen(),
                    '/regisPage': (context) => const RegistrationPageView(),
                    '/profilePage': (context) => const ProfilePage(),
                    '/homePage': (context) => const HomePage(),
                    '/preferencesPage': (context) => const PreferencesPage(),
                    '/promoCodePage': (context) => const PromoCodePage(),
                    '/bonusPage': (context) => const BonusPage(),
                    '/faqPage': (context) => const FaqPage(),
                    '/bonusGetPage': (context) => const BonusGetPage(),
                    '/creditCardPage': (context) => const CreditCardPage(),
                    '/address': (context) => const AddressPageView(),
                    '/share': (context) => const SharePage(),
                    '/orders': (context) => const MyOrdersPage(),
                    '/orderHistory': (context) => const OrderHistory(),
                    '/cartInfo': (context) => const CartInfoDelivery(),
                  },
                );
              },
            );
          }
          return SizedBox();
        });
  }
}

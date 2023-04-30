import 'package:first_flutter_app/scenes/cart_scene.dart';
import 'package:first_flutter_app/scenes/home_scene.dart';
import 'package:first_flutter_app/scenes/login_scene.dart';
import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/reserve_scene.dart';
import 'package:first_flutter_app/scenes/return_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'scenes/product_list_scene.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale("ar"),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates:  const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginScene(),
      routes: {
        '/':(context) => const HomeScene(),
        '/login':(context) => const LoginScene(),
        '/reserve': (context) => const ReserveScene(productList: []),
        '/rent_out':(context) => const RentoutScene(),
        '/return':(context) => const ReturnScene(),
        '/list':(context) => const ProductListScene(),
        '/cart':(context) => const CartScene()
      },
    );
  }
}

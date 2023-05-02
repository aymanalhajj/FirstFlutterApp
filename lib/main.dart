import 'package:first_flutter_app/scenes/cart_scene.dart';
import 'package:first_flutter_app/scenes/home_scene.dart';
import 'package:first_flutter_app/scenes/login_scene.dart';
import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/rentouts_scene.dart';
import 'package:first_flutter_app/scenes/reservations_scene.dart';
import 'package:first_flutter_app/scenes/reserve_scene.dart';
import 'package:first_flutter_app/scenes/return_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'scenes/sub_scene/product_list_scene.dart';

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
        '/reserve': (context) => const ReservationScene(),
        '/rent_out':(context) => const RentOutsScene(),
        '/return':(context) => const RentOutsScene(),
        '/list':(context) => Text('data'),//const ProductListScene(),
        '/cart':(context) => const CartScene()
      },
    );
  }
}

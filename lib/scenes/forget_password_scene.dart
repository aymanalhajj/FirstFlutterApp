import 'dart:math';

import 'package:first_flutter_app/scenes/sub_scene/app_drawer.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScene extends StatelessWidget {
  const ForgetPasswordScene({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      drawer: const AppDrawer(),
      body: Container(
        width: 500,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            //border: Border.all(width: 2, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.orangeAccent,
            boxShadow: [
              BoxShadow(
                  offset: Offset.fromDirection(0.25 * pi, 5.0),
                  blurRadius: 10.0)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Log In",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.black)),
          TextButton(
              child: const Text("Log In"),
              onPressed: () {
                Navigator.pop(context);
              })
        ]),
      ),
    );
  }
}

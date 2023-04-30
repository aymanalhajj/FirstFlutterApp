import 'dart:math';

import 'package:flutter/material.dart';

class ForgetPasswordScene extends StatelessWidget {
  const ForgetPasswordScene({super.key});

  Widget getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: [
                Image.asset('assets/images/academyLogo.png'),
                Container(
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    'Pioneering Academy',
                  ),
                )
              ],
            ),
          ),
          ListTile(
            selected: true,
            leading: const Icon(Icons.looks_one),
            title: const Text("حجز"),
            onTap: () {
              Navigator.pushNamed(context, '/reserve');
            },
          ),
          ListTile(
            leading: const Icon(Icons.looks_two),
            title: const Text("تأجير"),
            onTap: () {
              Navigator.pushNamed(context, '/rent_out');
            },
          ),
          ListTile(
            leading: const Icon(Icons.looks_3),
            title: const Text("إرجاع"),
            onTap: () {
              Navigator.pushNamed(context, '/return');
            },
          ),
          ListTile(
            leading: const Icon(Icons.looks_3),
            title: const Text("الرئيسية"),
            onTap: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.looks_3),
            title: const Text("تسجيل الخروج"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      drawer: getDrawer(context),
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

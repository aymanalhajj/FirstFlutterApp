import 'dart:math';

import 'package:flutter/material.dart';

class RentoutScene extends StatelessWidget {
  const RentoutScene({super.key});
  Widget getDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Stack(
            children: [
              Image.asset('lib/assets/images/academyLogo.png'),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Pioneering Academy',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.looks_one),
          title: const Text("Reserve"),
          onTap: () {
            Navigator.pushNamed(context, '/reserve');
          },
        ),
        ListTile(
          leading: const Icon(Icons.looks_one),
          title: const Text("Rent out"),
          onTap: () {
            Navigator.pushNamed(context, '/rent_out');
          },
        ),
        ListTile(
          leading: const Icon(Icons.looks_one),
          title: const Text("Return"),
          onTap: () {
            Navigator.pushNamed(context, '/return');
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
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

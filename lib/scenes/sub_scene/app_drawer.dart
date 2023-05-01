import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{
  const AppDrawer({super.key});


  @override
  Widget build(BuildContext context){
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
              leading: const Icon(Icons.home),
              title: const Text("الرئيسية"),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                //In case you don't use named routing:
                //Navigator.of(context).popUntil((route) => route.isFirst);
                //For Homepage it will work from any other page.
                //Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.catching_pokemon),
              title: const Text("طلبات الحجز"),
              onTap: () {
                Navigator.pushNamed(context, '/reserve');
              },
            ),
            ListTile(
              leading: const Icon(Icons.bedroom_parent),
              title: const Text("طلبات التأجير"),
              onTap: () {
                Navigator.pushNamed(context, '/rent_out');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delivery_dining_outlined),
              title: const Text("إرجاع الأصناف"),
              onTap: () {
                Navigator.pushNamed(context, '/return');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("تسجيل الخروج"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
  }
}
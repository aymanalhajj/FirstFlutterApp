import 'dart:convert';
import 'dart:math';

import 'package:first_flutter_app/data/models/shopping_cart.dart';
import 'package:first_flutter_app/scenes/sub_scene/app_drawer.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../data/services/sqlite_service.dart';
import '../repository/api_repository.dart';

class HomeScene extends StatefulWidget {
  const HomeScene({super.key});

  @override
  State<HomeScene> createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> {
  late List<ShoppingCart> _productList;
  late SQLiteService _sqliteService;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
    //_sqliteService.initDatabase();
    //this._sqliteService.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الرئيسية"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_basket),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        margin: const EdgeInsets.all(20),
        //child: GridView.extent(
        //maxCrossAxisExtent: 200,
        child: FutureBuilder(
          future: ApiRepository.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Material(
                  child: Center(child: CircularProgressIndicator()));
            }

            if (snapshot.hasError) {
              return Material(
                  child: Center(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Constants.fetchDataError),
                  Text(snapshot.error.toString())
                ],
              )));
            }
            if (!snapshot.hasData) {
              return Material(child: Text(Constants.noDataError));
            }
            final data = jsonDecode(utf8.decode(snapshot.data!.bodyBytes));
            _productList = data['items']
                .map<ShoppingCart>((p) => ShoppingCart.fromMap({
                      'productPath': p["product_path"],
                      'productName': p["product_name"],
                      'productPrice': p["product_price"],
                      'productId': p["product_id"],
                    }))
                .toList();
            //final List dataList = jsonDecode(snapshot.data!.body);
            final List<Widget> widgets = _productList
                .map<Widget>(
                  (p) =>

                      Center(
                    child: SizedBox(
                      width: 300,
                      child: Card(
                        elevation: 8,
                        margin: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              '${Constants.imageBaseURL}${p.productPath}',
                              height: 140,
                              width: 140,
                              fit: BoxFit.contain,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(p.productName)),
                                Text('${p.productPrice} YER'),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                    color: Colors.deepPurple,
                                    icon: const Icon(Icons.add_shopping_cart),
                                    onPressed: () {
                                      _sqliteService.addItem(p);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList();

            return ListView(
              // scrollDirection: Axis.vertical,
              children: widgets,
            );
          },
        ),
      ),
    );
  }
}

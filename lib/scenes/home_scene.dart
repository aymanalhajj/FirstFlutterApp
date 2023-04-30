import 'dart:convert';
import 'dart:math';

import 'package:first_flutter_app/data/models/shopping_cart.dart';
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
  late List<Map<String, dynamic>> _productList;
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
    return FutureBuilder(
      future: ApiRepository.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Material(
              child: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Material(
              child:
                  Text(Constants.fetchDataError + snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          return Material(child: Text(Constants.noDataError));
        }
        final data = jsonDecode(utf8.decode(snapshot.data!.bodyBytes));
        _productList = data['items']
            .map<Map<String, dynamic>>((p) => {
                  'productPath': p["product_path"],
                  'productName': p["product_name"],
                  'productPrice': p["product_price"],
                  'productId': p["product_id"],
                })
            .toList();
        //final List dataList = jsonDecode(snapshot.data!.body);
        final List<Widget> widgets = _productList
            .map<Widget>((p) => Center(
                child: SizedBox(
                    width: 300,
                    height: 150,
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(2)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'http://localhost:8080/ords/trade/trade_v1/get_file?p_mime_type=image/jpeg&p_file_name=${p["productPath"]}',
                                height: 140,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  //Image.asset('assets/images/academyLogo.png', fit: BoxFit.cover),

                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text('${p['productName']}')),

                                  Text('${p['productPrice']} YER'),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: IconButton(
                                        color: Colors.deepPurple,
                                        icon:
                                            const Icon(Icons.add_shopping_cart),
                                        onPressed: () {
                                          //_sqliteService.initDatabase();
                                          _sqliteService
                                              .addItem(ShoppingCart.fromMap(p));
                                        },
                                      ))
                                ],
                              )
                            ])))))
            .toList();
        return Scaffold(
            appBar: AppBar(
              title: Text("tr"),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Icon(Icons.shopping_basket),
                )
              ],
            ),
            body: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    //border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset.fromDirection(0.25 * pi, 5.0),
                          blurRadius: 10.0)
                    ]),
                //child: GridView.extent(
                //maxCrossAxisExtent: 200,
                child: ListView(
                  // scrollDirection: Axis.vertical,
                  children: widgets,
                )));
      },
    );
  }
}

import 'dart:math';

import 'package:first_flutter_app/data/models/shopping_cart.dart';
import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/sub_scene/cart_item.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_card.dart';
import 'package:first_flutter_app/scenes/reserve_scene.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../data/services/sqlite_service.dart';

class CartScene extends StatefulWidget {
  const CartScene({super.key});

  @override
  State<CartScene> createState() => _CartSceneState();
}

class _CartSceneState extends State<CartScene> {
  late List<ShoppingCart> _productList;
  late SQLiteService _sqliteService;
  int simpleIntInput = 0;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
  }

  void quantityIncrement(int index) {
    if (int.parse(_productList[index].productQuantity) < 100) {
      setState(() {
        _productList[index].productQuantity =
            (int.parse(_productList[index].productQuantity) + 1).toString();
        _sqliteService.updateQuantity(_productList[index]);
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      _productList.removeAt(index);
    });
  }

  void quantityDecrement(int index) {
    if (int.parse(_productList[index].productQuantity) > 1) {
      setState(() {
        _productList[index].productQuantity =
            (int.parse(_productList[index].productQuantity) - 1).toString();
        _sqliteService.updateQuantity(_productList[index]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سلة التسوق"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 2),
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                    child: const Text("حجز"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) {
                        return ReserveScene(productList: _productList);
                      }));
                    },
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                      child: const Text("تأجير"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return  RentOutScene(productList: _productList.map((e) => e.toMap()).toList(),);
                        }));
                      })
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                  right: 20, left: 20, top: 5, bottom: 20),
              decoration: BoxDecoration(
                  //border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset.fromDirection(0.25 * pi, 5.0),
                        blurRadius: 10.0)
                  ]),
              child: FutureBuilder(
                future: _sqliteService.getItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Material(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return Text(
                        Constants.fetchDataError + snapshot.error.toString());
                  }
                  if (!snapshot.hasData) {
                    return Text(Constants.noDataError);
                  }
                  _productList = snapshot.data!;

                  return ListView.builder(
                    itemCount: _productList.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        data: _productList[index],
                        remove: removeItem,
                        index: index,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

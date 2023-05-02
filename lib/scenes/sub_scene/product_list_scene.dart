import 'dart:math';

import 'package:first_flutter_app/data/models/shopping_cart.dart';
import 'package:first_flutter_app/scenes/sub_scene/cart_item.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_card.dart';
import 'package:first_flutter_app/scenes/reserve_scene.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../data/services/sqlite_service.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.productList});
  final List<Map<String, dynamic>> productList;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            //border: Border.all(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset.fromDirection(0.25 * pi, 5.0),
                  blurRadius: 10.0)
            ]),
        child: ListView.builder(
          itemCount: widget.productList.length,
          itemBuilder: (context, index) {
            return ProductCard(data: widget.productList[index]);
          },
        ));
  }
}

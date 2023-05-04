import 'package:first_flutter_app/data/models/rentout.dart';
import 'package:first_flutter_app/scenes/return_scene.dart';
import 'package:first_flutter_app/scenes/sub_scene/my_table_row.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_list_scene.dart';
import 'package:flutter/material.dart';

class ReturnDetailScene extends StatelessWidget {
  const ReturnDetailScene(
      {super.key, required this.productList, required this.rentOut});
  final List<Map<String, dynamic>> productList;
  final Map<String, dynamic> rentOut;
  final String title = "تفاصيل الإرجاع";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            MyTableRow(
              data: rentOut,
              actions: const Padding(
                padding: EdgeInsets.all(5),
              ),
            ),
            Expanded(
                child: ProductList(
              productList: productList,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

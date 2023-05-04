import 'package:first_flutter_app/data/models/rentout.dart';
import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/return_scene.dart';
import 'package:first_flutter_app/scenes/sub_scene/my_table_row.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_list_scene.dart';
import 'package:flutter/material.dart';
import '../data/models/reservation.dart';

class RentOutDetailScene extends StatelessWidget {
  const RentOutDetailScene(
      {super.key, required this.productList, this.rentOut});
  final List<Map<String, dynamic>> productList;
  final Rentout? rentOut;
  final String title = "تفاصيل التأجير";

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
              data: rentOut!.toMap(),
              actions: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return ReturnScene(rentOut: rentOut);
                          }));
                        },
                        child: const Text('استرجاع')),
                  ],
                ),
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

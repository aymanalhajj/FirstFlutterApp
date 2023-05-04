import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/sub_scene/my_table_row.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_list_scene.dart';
import 'package:flutter/material.dart';
import '../data/models/reservation.dart';

class ReservationDetailScene extends StatelessWidget {
  const ReservationDetailScene(
      {super.key, required this.productList, this.reservation});
  final List<Map<String, dynamic>> productList;
  final Reservation? reservation;
  final String title = "تفاصيل الحجز";

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
              data: reservation!.toMap(),
              actions: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return RentOutScene(
                                productList: productList,
                                reservation: reservation);
                          }));
                        },
                        child: const Text('تأجير')),
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

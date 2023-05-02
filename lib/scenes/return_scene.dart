import 'dart:math';

import 'package:first_flutter_app/data/models/rentout.dart';
import 'package:first_flutter_app/data/models/rentout_return.dart';
import 'package:first_flutter_app/data/models/reservation.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_list_scene.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/services/sqlite_service.dart';

class ReturnScene extends StatefulWidget {
  const ReturnScene({super.key, required this.rentOut,});
  final Rentout? rentOut;
  @override
  State<ReturnScene> createState() => _ReturnSceneState();
}

class _ReturnSceneState extends State<ReturnScene> {
  late Map<String, dynamic> _data;
  late SQLiteService _sqliteService;
  int simpleIntInput = 0;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
    _data = {
      'returnId': 1,
      'rentoutId': (widget.rentOut != null) ? widget.rentOut!.rentoutId : null,
      'returnDate': (widget.rentOut != null)
          ? widget.rentOut!.returnDate.millisecondsSinceEpoch
          : DateTime.now().millisecondsSinceEpoch,
      'clientName': (widget.rentOut != null) ? widget.rentOut!.clientName : "",
      'items': widget.rentOut!.items!.map((e) => e.toMap()).toList()
    };
  }

  Future<DateTime> _selectDate(
      BuildContext context, DateTime defaultDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: defaultDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != defaultDate) {
      return Future.value(picked);
    } else {
      return Future.value(defaultDate);
    }
  }

  Future<void> savedRentOutReturn() async {
    _sqliteService.addRentoutReturn(RentoutReturn.fromMap(_data));
    Navigator.pop(context);
    if (kDebugMode) {
      print("savedRentOutReturn");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("استرجاع الأصناف"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: TextEditingController(
                              text: _data['rentoutId'].toString()),
                          decoration: const InputDecoration(
                              enabled: false,
                              label: Text('رقم فاتورة التأجير'),
                              prefixIcon: Icon(Icons.person)),
                          onChanged: (value) {
                            setState(() {
                              _data['rentoutId'] = value;
                            });
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: _data['clientName'],
                          decoration: const InputDecoration(
                              label: Text('اسم العميل'),
                              prefixIcon: Icon(Icons.person)),
                          onChanged: (value) {
                            setState(() {
                              _data['clientName'] = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'تاريخ الارجاع: ',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                                "${DateTime.fromMillisecondsSinceEpoch(_data['returnDate']).toLocal()}"
                                    .split(' ')[0]),
                            const SizedBox(
                              height: 20.0,
                            ),
                            IconButton(
                                icon: const Icon(Icons.date_range),
                                onPressed: () {
                                  _selectDate(
                                          context,
                                          DateTime.fromMillisecondsSinceEpoch(
                                              _data['returnDate']))
                                      .then((value) {
                                    setState(() {
                                      _data['returnDate'] =
                                          value.millisecondsSinceEpoch;
                                    });
                                  });
                                }),
                          ],
                        ),
                        ElevatedButton(
                            child: const Text("إسترجاع"),
                            onPressed: () {
                              savedRentOutReturn();
                            })
                      ])),
            ),

            Expanded(
              child: ProductList(
                productList: _data['items'],
              ),
            )],
        ),
      ),
    );
  }
}

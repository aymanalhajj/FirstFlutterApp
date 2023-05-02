import 'dart:math';

import 'package:first_flutter_app/data/models/rentout.dart';
import 'package:first_flutter_app/data/models/reservation.dart';
import 'package:first_flutter_app/scenes/sub_scene/product_list_scene.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/services/sqlite_service.dart';

class RentOutScene extends StatefulWidget {
  const RentOutScene({super.key, required this.productList, this.reservation});
  final List<Map<String, dynamic>> productList;
  final Reservation? reservation;
  @override
  State<RentOutScene> createState() => _RentOutSceneState();
}

class _RentOutSceneState extends State<RentOutScene> {
  late Map<String, dynamic> _data;
  late SQLiteService _sqliteService;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
    _data = {
      'rentoutId': 1,
      'reservationId': (widget.reservation != null)
          ? widget.reservation!.reservationId
          : null,
      'reserveDate': (widget.reservation != null)
          ? widget.reservation!.reserveDate.millisecondsSinceEpoch
          : DateTime.now().millisecondsSinceEpoch,
      'rentoutDate': (widget.reservation != null)
          ? widget.reservation!.rentoutDate.millisecondsSinceEpoch
          : DateTime.now().millisecondsSinceEpoch,
      'returnDate': (widget.reservation != null)
          ? widget.reservation!.returnDate.millisecondsSinceEpoch
          : DateTime.now().millisecondsSinceEpoch,
      'clientName':
          (widget.reservation != null) ? widget.reservation!.clientName : "",
      'items': widget.productList
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

  Future<void> saveRentOut() async {
    _sqliteService.addRentout(Rentout.fromMap(_data));
    Navigator.pop(context);
    if (kDebugMode) {
      print("saveReservation");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تأجير الأصناف"),
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
                      decoration: const InputDecoration(
                          label: Text('اسم العميل'),
                          prefixIcon: Icon(Icons.person)),
                      onChanged: (value) {
                        setState(() {
                          _data['clientName'] = value;
                        });
                      },
                      initialValue:  _data['clientName'],
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text:
                              "${DateTime.fromMillisecondsSinceEpoch(_data['reserveDate']).toLocal()}"
                                  .split(' ')[0]),
                          decoration: const InputDecoration(
                              label: Text('تاريخ الحجز'),
                              prefixIcon: Icon(Icons.date_range)),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.date_range,
                              color: Colors.blue),
                          onPressed: () {
                            _selectDate(
                                context,
                                DateTime.fromMillisecondsSinceEpoch(
                                    _data['reserveDate']))
                                .then((value) {
                              setState(() {
                                _data['reserveDate'] =
                                    value.millisecondsSinceEpoch;
                              });
                            });
                          }),
                    ]),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text:
                              "${DateTime.fromMillisecondsSinceEpoch(_data['rentoutDate']).toLocal()}"
                                  .split(' ')[0]),
                          decoration: const InputDecoration(
                              label: Text('تاريخ التأجير'),
                              prefixIcon: Icon(Icons.date_range)),
                        ),
                      ),
                        IconButton(
                            icon: const Icon(Icons.date_range,
                                color: Colors.blue),
                            onPressed: () {
                              _selectDate(
                                  context,
                                  DateTime.fromMillisecondsSinceEpoch(
                                      _data['rentoutDate']))
                                  .then((value) {
                                setState(() {
                                  _data['rentoutDate'] =
                                      value.millisecondsSinceEpoch;
                                });
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text:
                              "${DateTime.fromMillisecondsSinceEpoch(_data['returnDate']).toLocal()}"
                                  .split(' ')[0]),
                          decoration: const InputDecoration(
                              label: Text('تاريخ الارجاع'),
                              prefixIcon: Icon(Icons.date_range)),
                        ),
                      ),
                        IconButton(
                            icon: const Icon(Icons.date_range,color: Colors.blue),
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
                    const SizedBox(height: 5,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
                        child: const Text("تأجير"),
                        onPressed: () {
                          saveRentOut();
                        })
                  ],
                ),
              ),
            ),
            Expanded(
              child: ProductList(
                productList: _data['items'],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:first_flutter_app/data/models/reservation.dart';
import 'package:first_flutter_app/data/models/reservation_item.dart';
import 'package:first_flutter_app/scenes/reservations_scene.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/shopping_cart.dart';
import '../data/services/sqlite_service.dart';

class ReserveScene extends StatefulWidget {
  const ReserveScene({super.key, required this.productList});
  final List<ShoppingCart> productList;
  @override
  State<ReserveScene> createState() => _ReserveSceneState();
}

class _ReserveSceneState extends State<ReserveScene> {
  late Map<String, dynamic> _data;
  late SQLiteService _sqliteService;
  int simpleIntInput = 0;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
    _data = {
      'reservationId': 1,
      'reserveDate': DateTime.now().millisecondsSinceEpoch,
      'rentoutDate': DateTime.now().millisecondsSinceEpoch,
      'returnDate': DateTime.now().millisecondsSinceEpoch,
      'clientName': "",
      'items': widget.productList.map((e) => e.toMap()).toList()
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

  Future<void> saveReservation() async {
    _sqliteService.addReservation(Reservation.fromMap(_data));
    Navigator.pop(context);
    if (kDebugMode) {
      print("saveReservation");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حجز الأصناف"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return const ReservationScene();
                }));
              },
              child: Text('حجز'))
        ],
      ),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        width: 500,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            //border: Border.all(width: 2, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset.fromDirection(0.25 * pi, 5.0),
                  blurRadius: 10.0)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            decoration: const InputDecoration(
                label: Text('اسم العميل'), prefixIcon: Icon(Icons.person)),
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
                'تاريخ الحجز: ',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                  "${DateTime.fromMillisecondsSinceEpoch(_data['reserveDate']).toLocal()}"
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
                                _data['reserveDate']))
                        .then((value) {
                      setState(() {
                        _data['reserveDate'] = value.millisecondsSinceEpoch;
                      });
                    });
                  }),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'تاريخ التأجير: ',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                  "${DateTime.fromMillisecondsSinceEpoch(_data['rentoutDate']).toLocal()}"
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
                                _data['rentoutDate']))
                        .then((value) {
                      setState(() {
                        _data['rentoutDate'] = value.millisecondsSinceEpoch;
                      });
                    });
                  }),
            ],
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
                        _data['returnDate'] = value.millisecondsSinceEpoch;
                      });
                    });
                  }),
            ],
          ),
          ElevatedButton(
              child: const Text("حجز"),
              onPressed: () {
                saveReservation();
              })
        ]),
      )),
    );
  }
}

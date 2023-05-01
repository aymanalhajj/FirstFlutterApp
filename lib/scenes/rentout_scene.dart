import 'dart:math';

import 'package:first_flutter_app/data/models/rentout.dart';
import 'package:first_flutter_app/data/models/reservation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/services/sqlite_service.dart';

class RentOutScene extends StatefulWidget {
  const RentOutScene({super.key, required this.productList,this.reservation});
  final List<Map<String, dynamic>> productList;
  final Reservation? reservation;
  @override
  State<RentOutScene> createState() => _RentOutSceneState();
}

class _RentOutSceneState extends State<RentOutScene> {
  late Map<String, dynamic> _data;
  late SQLiteService _sqliteService;
  int simpleIntInput = 0;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
    _data = {
      'rentoutId': 1,
      'reservationId': (widget.reservation != null)? widget.reservation!.reservationId : null,
      'reserveDate':  (widget.reservation != null)? widget.reservation!.reserveDate.millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
      'rentoutDate':  (widget.reservation != null)? widget.reservation!.rentoutDate.millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
      'returnDate':  (widget.reservation != null)? widget.reservation!.returnDate.millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
      'clientName': (widget.reservation != null)? widget.reservation!.clientName :"",
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
            initialValue: _data['clientName'],
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
              child: const Text("تأجير"),
              onPressed: () {
                saveRentOut();
              })
        ]),
      )),
    );
  }
}

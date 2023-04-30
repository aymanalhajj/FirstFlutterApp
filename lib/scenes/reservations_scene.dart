import 'dart:math';

import 'package:first_flutter_app/data/models/reservation.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../data/models/shopping_cart.dart';
import '../data/services/sqlite_service.dart';

class ReservationScene extends StatefulWidget {
  const ReservationScene({super.key});
  @override
  State<ReservationScene> createState() => _ReservationSceneState();
}

class _ReservationSceneState extends State<ReservationScene> {
  late Map<String, dynamic> _data;
  late SQLiteService _sqliteService;
  late List<Reservation> _list;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
    _data = {
      'reserveDate': DateTime.now(),
      'rentoutDate': DateTime.now(),
      'returnDate': DateTime.now(),
      'clientName': ""
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حجز الأصناف"),
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
        child: FutureBuilder(
              future: _sqliteService.getAllReservations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Material(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError) {
                  return Text(
                      Constants.fetchDataError + snapshot.error.toString());
                }
                if (!snapshot.hasData ||  snapshot.data == null ||  snapshot.data!.isEmpty) {
                  return Text(Constants.noDataError);
                }
                _list = snapshot.data!;

                return ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: SizedBox(
                        width: 350,
                        height: 200,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(2)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    //Image.asset('assets/images/academyLogo.png', fit: BoxFit.cover),

                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(_list[index].clientName)),

                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(_list[index]
                                            .reserveDate
                                            .toString())),

                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(_list[index]
                                            .rentoutDate
                                            .toString())),
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(_list[index]
                                            .returnDate
                                            .toString())),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        child: const Text('تأجير'))
                                  ],
                                )
                              ]),
                        ),
                      ),
                    );
                  },
                );
              }),
      )),
    );
  }
}

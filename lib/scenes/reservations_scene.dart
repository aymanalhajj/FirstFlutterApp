import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/reservation_detail_scene.dart';
import 'package:first_flutter_app/scenes/reserve_scene.dart';
import 'package:first_flutter_app/scenes/sub_scene/my_table_row.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../data/models/reservation.dart';
import '../data/services/sqlite_service.dart';

class ReservationScene extends StatefulWidget {
  const ReservationScene({super.key});
  final String title = "طلبات الحجز";
  @override
  State<ReservationScene> createState() => _ReservationSceneState();
}

class _ReservationSceneState extends State<ReservationScene> {
  late SQLiteService _sqliteService;
  late List<Reservation> _list;
  @override
  void initState() {
    super.initState();
    _sqliteService = SQLiteService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return Text(Constants.noDataError);
              }
              _list = snapshot.data!;

              return ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return MyTableRow(
                    data: _list[index].toMap(),
                    actions: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (c) {
                                      return RentOutScene(
                                        productList: _list[index]
                                            .items!
                                            .map((e) => e.toMap())
                                            .toList(),
                                        reservation: _list[index],
                                      );
                                    }));
                                  },
                                  child: const Text('تأجير')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (c) {
                                      return ReservationDetailScene(
                                          productList: _list[index]
                                              .items!
                                              .map((e) => e.toMap())
                                              .toList(),
                                          reservation: _list[index]);
                                    }));
                                  },
                                  child: const Text('التفاصيل'))
                            ])),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _sqliteService.getItems().then((value) =>
                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return ReserveScene(productList: value);
                })));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

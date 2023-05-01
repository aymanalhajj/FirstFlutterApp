import 'dart:math';

import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/return_scene.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../data/models/rentout.dart';
import '../data/services/sqlite_service.dart';

class RentOutsScene extends StatefulWidget {
  const RentOutsScene({super.key});
  final String title = "طلبات التأجير";
  @override
  State<RentOutsScene> createState() => _RentOutsSceneState();
}

class _RentOutsSceneState extends State<RentOutsScene> {
  late Map<String, dynamic> _data;
  late SQLiteService _sqliteService;
  late List<Rentout> _list;
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
            future: _sqliteService.getAllRentouts(),
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
                  return Center(
                    child: SizedBox(
                      width: 350,
                      height: 200,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
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
                                      child: Text(
                                          _list[index].reserveDate.toString())),

                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                          _list[index].rentoutDate.toString())),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                          _list[index].returnDate.toString())),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                                          return ReturnScene(rentOut: _list[index]);
                                        }));
                                      },
                                      child: const Text('استرجاع'))
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('التفاصيل'))
                            ]),
                      ),
                    ),
                  );
                },
              );
            }),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _sqliteService.getItems().then((value) =>
                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return RentOutScene(productList: value.map((e) => e.toMap()).toList(),);
                })));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'dart:math';

import 'package:first_flutter_app/scenes/rentout_detail_scene.dart';
import 'package:first_flutter_app/scenes/rentout_scene.dart';
import 'package:first_flutter_app/scenes/return_scene.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../data/models/rentout.dart';
import '../data/services/sqlite_service.dart';
import 'sub_scene/my_table_row.dart';

class RentOutsScene extends StatefulWidget {
  const RentOutsScene({super.key});
  final String title = "طلبات التأجير";
  @override
  State<RentOutsScene> createState() => _RentOutsSceneState();
}

class _RentOutsSceneState extends State<RentOutsScene> {
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
                                        return ReturnScene(
                                            rentOut: _list[index]);
                                      }));
                                    },
                                    child: const Text('استرجاع')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (c) {
                                        return RentOutDetailScene(
                                            productList: _list[index]
                                                .items!
                                                .map((e) => e.toMap())
                                                .toList(),
                                            rentOut: _list[index]);
                                      }));
                                    },
                                    child: const Text('التفاصيل'))
                              ])),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _sqliteService.getItems().then((value) =>
                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return RentOutScene(
                    productList: value.map((e) => e.toMap()).toList(),
                  );
                })));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

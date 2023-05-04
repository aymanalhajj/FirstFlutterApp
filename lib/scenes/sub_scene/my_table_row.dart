import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTableRow extends StatelessWidget {
  const MyTableRow({super.key, required this.data, required this.actions});

  final Map<String, dynamic> data;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.all(10),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Table(
                  children: [
                    TableRow(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, right: 2, left: 6),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: const Text('اسم العميل:',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, right: 2, left: 2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Text(data['clientName']),
                      ),
                    ]),
                    TableRow(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, right: 2, left: 6),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: const Text('تاريخ الحجز:',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, right: 2, left: 2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Text(DateFormat('dd/MM/yyyy')
                            .format(DateTime.fromMillisecondsSinceEpoch(data['reserveDate']))),
                      ),
                    ]),
                    TableRow(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 4,
                          right: 2,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: const Text('تاريخ التأجير:',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, right: 2, left: 2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Text(DateFormat('dd/MM/yyyy')
                            .format(DateTime.fromMillisecondsSinceEpoch(data['rentoutDate'])),
                      )),
                    ]),
                    TableRow(children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 4,
                          right: 2,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: const Text('تاريخ الإرجاع:',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, right: 2, left: 2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(data['returnDate'])),
                        ),
                      ),
                    ]),
                  ],
                ),
                actions
              ],
            )),
      ),
    );
  }
}

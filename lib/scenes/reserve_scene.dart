import 'dart:math';

import 'package:flutter/material.dart';

class ReserveScene extends StatefulWidget {
  const ReserveScene({super.key});

  @override
  State<ReserveScene> createState() => _ReserveSceneState();
}

class _ReserveSceneState extends State<ReserveScene> {
  DateTime reserveDate = DateTime.now();
  DateTime rentoutDate = DateTime.now();
  DateTime returnDate = DateTime.now();

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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            decoration: InputDecoration(
                label: Text('اسم العميل'), prefixIcon: Icon(Icons.person)),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'تاريخ الحجز: ',
                style: TextStyle(color: Colors.red),
              ),
              Text("${reserveDate.toLocal()}".split(' ')[0]),
              const SizedBox(
                height: 20.0,
              ),
              IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () {
                    _selectDate(context, reserveDate).then((value) {
                      setState(() {
                        reserveDate = value;
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
              Text("${rentoutDate.toLocal()}".split(' ')[0]),
              const SizedBox(
                height: 20.0,
              ),
              IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () {
                    _selectDate(context, rentoutDate).then((value) {
                      setState(() {
                        rentoutDate = value;
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
              Text("${returnDate.toLocal()}".split(' ')[0]),
              const SizedBox(
                height: 20.0,
              ),
              IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () {
                    _selectDate(context, returnDate).then((value) {
                      setState(() {
                        returnDate = value;
                      });
                    });
                  }),
            ],
          ),
          ElevatedButton(
              child: const Text("حجز"),
              onPressed: () {
                //Navigator.pop(context);
              })
        ]),
      )),
    );
  }
}

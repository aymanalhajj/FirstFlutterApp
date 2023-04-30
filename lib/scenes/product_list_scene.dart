import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../repository/firebase_repository.dart';

class ProductListScene extends StatefulWidget {
  const ProductListScene({super.key});

  @override
  State<ProductListScene> createState() => _ProductListSceneState();
}

class _ProductListSceneState extends State<ProductListScene> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseRepository.fetchAllPeople(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(Constants.fetchDataError + snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return Text(Constants.noDataError);
        }

        final List<Widget> widgets = snapshot.data!.docs
            .map<Widget>((p) => Stack(
                  children: [
                    Image.asset('assets/images/academyLogo.png',
                        fit: BoxFit.cover),
                    //Image.network(p['imageUrl'], height: 300, width: 300, fit: BoxFit.cover),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child:
                            Text('${p['name']['first']} ${p['name']['last']}')),
                  ],
                ))
            .toList();
        return Material(
            child: Container(
                margin: const EdgeInsets.only(
                    top: 200, bottom: 100, left: 50, right: 50),
                decoration: BoxDecoration(
                    //border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset.fromDirection(0.25 * pi, 5.0),
                          blurRadius: 10.0)
                    ]),
                child: GridView.extent(
                  maxCrossAxisExtent: 300,
                  children: widgets,
                )));
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomDialogs {
  static void showMessage(BuildContext context, {String? message}) {
    showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFF1BC0C5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Text(Constants.messageTitle,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Text(
                        (message != null) ? message : Constants.successMessage,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(18),
                              alignment: Alignment.bottomCenter,
                            ),
                            child: Text(Constants.ok)),
                      )
                    ])),
          );
        });
  }

  static void showConfirm(BuildContext context, {String? message}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFF25ACB0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Text(Constants.messageTitle,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Text(
                        (message != null) ? message : Constants.successMessage,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly
                              ,children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop("ok");
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(18),
                                    alignment: Alignment.bottomCenter,
                                    backgroundColor:  Color(0xFF25ACB0)
                                ),
                                child: Text(Constants.ok)),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop("cancel");
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(18),
                                    alignment: Alignment.bottomCenter,
                                    backgroundColor: Colors.white
                                ),
                                child: Text(Constants.cancel,style: TextStyle(color: Color(0xFF25ACB0)),)),
                          ]))
                    ])),
          );
        });
  }

}

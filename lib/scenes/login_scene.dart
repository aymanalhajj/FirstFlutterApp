import 'dart:math';

import 'package:first_flutter_app/scenes/forget_password_scene.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../repository/firebase_repository.dart';
import '../repository/api_repository.dart';
import 'custom_dialogs.dart';

class LoginScene extends StatefulWidget {
  const LoginScene({super.key});

  @override
  State<LoginScene> createState() {
    return _LoginSceneState();
  }
}

class _LoginSceneState extends State<LoginScene> {
  Map<String, dynamic> data = {};

  final GlobalKey<FormState> _key = GlobalKey();
  void login() {
    if (_key.currentState!.validate()) {
      //CustomDialogs.showMessage(context);
      //var fetchPeople = FirebaseRepository.fetchPeople();
      Future<Response> response = ApiRepository.login(data);
      response.then((value) {
        print('response : ${value.body.toString()}');
      });
      print('Username : ${data["username"]}');
      print('Password : ${data["password"]}');
    }
  }

  String? usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return "يجب ادخال اسم المستخدم.!";
    } else {
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "يجب ادخال كلمة المرور.!";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _key,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin:
              const EdgeInsets.only(top: 200, bottom: 100, left: 50, right: 50),
          decoration: BoxDecoration(
              //border: Border.all(width: 2, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                    offset: Offset.fromDirection(0.25 * pi, 5.0),
                    blurRadius: 10.0)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("تسجيل الدخول",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.black)),
              TextFormField(
                decoration: const InputDecoration(
                    label: Text("اسم المستخدم"),
                    prefixIcon: Icon(Icons.person)),
                onChanged: (value) {
                  data["username"] = value;
                },
                validator: usernameValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    label: Text("كلمة المرور"), prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                onChanged: (value) {
                  data["password"] = value;
                },
                validator: passwordValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                  // print("object");
                },
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
                child: const Text("تسجيل الدخول"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  child: const Text("هل نسيت كلمة المرور؟"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScene()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

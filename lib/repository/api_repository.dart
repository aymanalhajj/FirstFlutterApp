import 'dart:convert';

import 'package:http/http.dart';

class ApiRepository {
  static Future<Response> login(Map<String, dynamic> payload) {
    String url = "http://localhost:8080/ords/trade/trade_v1/auth";
    url = "/ords/trade/trade_v1/auth";
    Uri uri = Uri(scheme: "http", host: "localhost", port: 8080, path: url);
    Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };
    Future<Response> response = post(uri, headers: headers, body: jsonEncode(payload));
    return response;
  }


  static Future<Response> getProducts() {
    String url = "http://localhost:8080/ords/trade/trade_v1/products";
    url = "/ords/trade/trade_v1/products";
    Uri uri = Uri(scheme: "http", host: "localhost", port: 8080, path: url);
    Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };
    Future<Response> response = get(uri, headers: headers);
    return response;
  }
}

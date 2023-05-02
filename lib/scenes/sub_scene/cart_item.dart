import 'package:first_flutter_app/Constants.dart';
import 'package:first_flutter_app/data/services/sqlite_service.dart';
import 'package:flutter/material.dart';

import '../../data/models/shopping_cart.dart';

class CartItem extends StatefulWidget {
  final ShoppingCart data;
  final int index;
  final Function(int) remove;
  const CartItem(
      {super.key,
      required this.data,
      required this.remove,
      required this.index});
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late ShoppingCart _data;
  late SQLiteService _sqliteservice;
  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _sqliteservice = SQLiteService();
  }

  void quantityIncrement() {
    if (int.parse(_data.productQuantity) < 100) {
      setState(() {
        _data.productQuantity =
            (int.parse(_data.productQuantity) + 1).toString();
        _sqliteservice.updateQuantity(_data);
      });
    }
  }

  void quantityDecrement() {
    if (int.parse(_data.productQuantity) > 1) {
      setState(() {
        _data.productQuantity =
            (int.parse(_data.productQuantity) - 1).toString();
        _sqliteservice.updateQuantity(_data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 150,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(2)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "${Constants.imageBaseURL}${_data.productPath}",
                height: 140,
                width: 140,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Image.asset('assets/images/academyLogo.png', fit: BoxFit.cover),

                  Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(_data.productName)),

                  Text('${_data.productPrice} YER'),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => quantityIncrement(),
                          icon: const Icon(Icons.add_circle,color: Colors.blue,)),
                      Text(_data.productQuantity.toString()),
                      IconButton(
                          onPressed: () => quantityDecrement(),
                          icon: const Icon(Icons.remove_circle,color: Colors.grey,))
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _sqliteservice.deleteItem(_data.productId);
                          widget.remove(widget.index);
                        });
                      },
                      icon: const Icon(Icons.remove_shopping_cart_sharp))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

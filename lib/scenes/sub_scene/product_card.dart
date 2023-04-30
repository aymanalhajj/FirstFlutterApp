import 'package:first_flutter_app/data/services/sqlite_service.dart';
import 'package:flutter/material.dart';

import '../../data/models/shopping_cart.dart';

class ProductCard extends StatefulWidget {
  final ShoppingCart data;
  final int index;
  final Function(int) remove;
  const ProductCard({super.key, required this.data,required this.remove,required this.index});
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
              'http://localhost:8080/ords/trade/trade_v1/get_file?p_mime_type=image/jpeg&p_file_name=${_data.productPath}',
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
                        icon: Icon(Icons.add_circle)),
                    Text(_data.productQuantity.toString()),
                    IconButton(
                        onPressed: () => quantityDecrement(),
                        icon: const Icon(Icons.remove_circle))
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
          ]),
        ),
      ),
    );
  }
}

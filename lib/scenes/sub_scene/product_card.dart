import 'package:first_flutter_app/Constants.dart';
import 'package:flutter/material.dart';


class ProductCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const ProductCard({super.key, required this.data});
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
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
                "${Constants.imageBaseURL}${widget.data['productPath']}",
                height: 140,
                width: 140,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(widget.data['productName'])),
                  Text('${widget.data['productPrice']} YER'),
                  Text(widget.data['productQuantity'].toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

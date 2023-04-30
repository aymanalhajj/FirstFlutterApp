class ShoppingCart {
   int productId;
   String productName;
   String productQuantity;
   String productPrice;
   String productPath;
  ShoppingCart(this.productId, this.productName, this.productPath,
      this.productPrice, this.productQuantity);
  ShoppingCart.fromMap(Map<String, dynamic> item)
      : productName = item['productName'],
        productId = item['productId'],
        productPath = item['productPath'],
        productPrice = item['productPrice'].toString(),
        productQuantity =
            (item['productQuantity'] != null) ? item['productQuantity'] : "1";

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productPath': productPath,
      'productPrice': productPrice,
      'productQuantity': productQuantity
    };
  }
}

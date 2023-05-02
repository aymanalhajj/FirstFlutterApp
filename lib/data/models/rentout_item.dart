class RentoutItem {
  int itemId;
  int rentoutId;
  int productId;
  String productName;
  String productQuantity;
  String productPrice;
  String productPath;
  RentoutItem(this.productPath, this.itemId,  this.productId,
      this.productName, this.productQuantity, this.productPrice,this.rentoutId);
  RentoutItem.fromMap(Map<String, dynamic> item)
      : itemId = 1,
        rentoutId = (item['rentoutId'] != null)
            ? item['rentoutId']
            : 1,
        productId = item['productId'],
        productPath = item['productPath'],
        productName = item['productName'],
        productQuantity = item['productQuantity'],
        productPrice = item['productPrice'];
  Map<String, dynamic> toMap() {
    return {
      //'itemId': itemId,
      'rentoutId': rentoutId,
      'productId': productId,
      'productName': productName,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'productPath': productPath,
    };
  }
}

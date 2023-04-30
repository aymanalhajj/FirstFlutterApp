class RentoutItem {
  int itemId;
  int rentoutId;
  int? reservationId;
  int productId;
  String productName;
  String productQuantity;
  String productPrice;
  RentoutItem(this.itemId, this.reservationId, this.productId,
      this.productName, this.productQuantity, this.productPrice,this.rentoutId);
  RentoutItem.fromMap(Map<String, dynamic> item)
      : itemId = 1,
        reservationId = item['reservationId'] ,
        rentoutId = (item['rentoutId'] != null)
            ? item['rentoutId']
            : 1,
        productId = item['productId'],
        productName = item['productName'],
        productQuantity = item['productQuantity'],
        productPrice = item['productPrice'];
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'rentoutId': rentoutId,
      'reservationId': reservationId,
      'productId': productId,
      'productName': productName,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
    };
  }
}

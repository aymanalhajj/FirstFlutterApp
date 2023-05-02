class ReservationItem {
  int itemId;
  int reservationId;
  int productId;
  String productName;
  String productQuantity;
  String productPrice;
  String productPath;
  ReservationItem(this.productPath,this.itemId, this.reservationId, this.productId,
      this.productName, this.productQuantity, this.productPrice);
  ReservationItem.fromMap(Map<String, dynamic> item)
      : itemId = 1,
        reservationId = (item['reservationId'] != null)
            ? item['reservationId']
            : 1,
        productId = item['productId'],
        productPath = item['productPath'],
        productName = item['productName'],
        productQuantity = item['productQuantity'],
        productPrice = item['productPrice'];
  Map<String, dynamic> toMap() {
    return {
      //'itemId': itemId,
      'reservationId': reservationId,
      'productId': productId,
      'productName': productName,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'productPath': productPath,
    };
  }
}

import 'package:first_flutter_app/data/models/rentout_item.dart';

class RentoutReturn {
  int returnId;
  int rentoutId;
  DateTime returnDate;
  String returnedBy;
  RentoutReturn(
      this.returnId, this.returnDate, this.returnedBy, this.rentoutId);
  RentoutReturn.fromMap(Map<String, dynamic> item)
      : rentoutId = item['rentoutId'],
        returnId = item['returnId'],
        returnDate = DateTime.fromMillisecondsSinceEpoch(item['returnDate']),
        returnedBy = item['returnedBy'];
  Map<String, dynamic> toMap() {
    return {
      //'returnId': returnId,
      'rentoutId': rentoutId,
      'returnDate': returnDate.millisecondsSinceEpoch,
      'returnedBy': returnedBy,
    };
  }
}

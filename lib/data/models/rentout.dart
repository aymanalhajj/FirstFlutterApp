import 'package:first_flutter_app/data/models/rentout_item.dart';

class Rentout {
  int rentoutId;
  int? reservationId;
  DateTime reserveDate;
  DateTime rentoutDate;
  DateTime returnDate;
  String clientName;
  List<RentoutItem>? items;
  Rentout(this.items, this.reservationId, this.returnDate, this.rentoutDate,
      this.reserveDate, this.clientName, this.rentoutId);
  Rentout.fromMap(Map<String, dynamic> item)
      : rentoutId = item['rentoutId'],
        reservationId = item['reservationId'],
        returnDate = DateTime.fromMillisecondsSinceEpoch(item['returnDate']),
        rentoutDate = DateTime.fromMillisecondsSinceEpoch(item['rentoutDate']),
        reserveDate = DateTime.fromMillisecondsSinceEpoch(item['reserveDate']),
        clientName = item['clientName'],
        items = (item['items'] != null)
            ? item['items']
                .map<RentoutItem>((e) => RentoutItem.fromMap(e))
                .toList()
            : null;
  Map<String, dynamic> toMap() {
    return {
      //'rentoutId': rentoutId,
      'reservationId': reservationId,
      'returnDate': returnDate.millisecondsSinceEpoch,
      'rentoutDate': rentoutDate.millisecondsSinceEpoch,
      'reserveDate': reserveDate.millisecondsSinceEpoch,
      'clientName': clientName,
    };
  }
}

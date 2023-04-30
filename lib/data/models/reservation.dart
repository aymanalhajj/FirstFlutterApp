import 'package:first_flutter_app/data/models/reservation_item.dart';

class Reservation {
  int reservationId;
  DateTime reserveDate;
  DateTime rentoutDate;
  DateTime returnDate;
  String clientName;
  List<ReservationItem>? items;
  Reservation(this.items, this.reservationId, this.returnDate, this.rentoutDate,
      this.reserveDate, this.clientName);
  Reservation.fromMap(Map<String, dynamic> item)
      : reservationId = item['reservationId'],
        returnDate = DateTime.fromMillisecondsSinceEpoch(item['returnDate']),
        rentoutDate = DateTime.fromMillisecondsSinceEpoch(item['rentoutDate']),
        reserveDate = DateTime.fromMillisecondsSinceEpoch(item['reserveDate']),
        clientName = item['clientName'],
        items = (item['items'] !=null )?item['items'].map<ReservationItem>((e) => ReservationItem.fromMap(e)).toList():null
  ;
  Map<String, dynamic> toMap() {
    return {
      //'reservationId': reservationId,
      'returnDate': returnDate.millisecondsSinceEpoch,
      'rentoutDate': rentoutDate.millisecondsSinceEpoch,
      'reserveDate': reserveDate.millisecondsSinceEpoch,
      'clientName': clientName,
    };
  }
}

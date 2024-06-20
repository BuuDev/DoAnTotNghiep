import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  String type;
  String date;
  List<String> event_name;
  String? checkout;
  String? checkin;
  int companyId;

  Event({
    required this.id,
    required this.type,
    required this.date,
    required this.event_name,
    required this.companyId,
    required this.checkin,
    required this.checkout,
  });
  String events() {
    if (checkout!.isEmpty) {
      return 'nghỉ làm';
    }
    if (tach() < 8) {
      return 'đi muộn';
    } else if (tach() >= 8) {
      return 'đi làm';
    }
    return '';
  }

  int tach() {
    if (checkin!.isEmpty || checkout!.isEmpty) {
      return 0;
    }
    DateTime now1 = DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkout!);

    String formattedTime = DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkin!));
    String formattedTime1 = DateFormat.Hms().format(now1);

    DateFormat dateFormat = DateFormat('hh:mm:ss');

    DateTime durationStart = dateFormat.parse(formattedTime);
    DateTime durationEnd = dateFormat.parse(formattedTime1);

    return durationEnd.difference(durationStart).inHours;
  }

  String thoiGianLamViec() {
    if (checkin!.isEmpty || checkout!.isEmpty) {
      return '';
    }
    String formatCheckIn = DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkin!));
    String formatCheckout = DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkout!));

    DateTime durationStart = DateFormat('hh:mm:ss').parse(formatCheckIn);
    DateTime durationEnd = DateFormat('hh:mm:ss').parse(formatCheckout);

    return durationEnd.difference(durationStart).toString().substring(0, 10);
  }

  String tachCheckIn() {
    if (checkin!.isEmpty) {
      return '';
    }
    return DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkin!));
  }

  String tachCheckOut() {
    if (checkout!.isEmpty) {
      return '';
    }
    return DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkout!));
  }

  @override
  String toString() => events();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

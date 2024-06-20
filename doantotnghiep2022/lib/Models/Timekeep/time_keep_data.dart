import 'package:doantotnghiep/Models/UserSkinDetective/user_demo.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'time_keep_data.g.dart';

@JsonSerializable()
class TimeKeepData {
  int? id;
  int user_id;
  String? checkin;
  String? checkout;
  String? date;
  String? status;
  String created_at;
  String updated_at;
  UserDemo? user;

  TimeKeepData({
    this.id,
    required this.user_id,
    required this.checkin,
    required this.checkout,
    required this.date,
    required this.status,
    required this.created_at,
    required this.updated_at,
    this.user,
  });

  String events() {
    if (status == '2') {
      return 'nghỉ làm';
    }
    if (status == '0') {
      if (checkin != null && checkout != null) {
        return 'chua duyet';
      }
      return '';
    } else {
      if (checkin == null) {
        return 'nghỉ làm';
      } else if (checkout == null) {
        return '';
      } else if (checkin != null && checkout != null) {
        if (tach() < 8) {
          return 'đi muộn';
        } else if (tach() >= 8) {
          return 'đi làm';
        }
      }
    }
    return '';
  }

  int tach() {
    // if (checkout == null) {
    //   return 0;
    // }
    DateTime now1 = DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkout!);

    String formattedTime = DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkin!));
    String formattedTime1 = DateFormat.Hms().format(now1);

    DateFormat dateFormat = DateFormat('hh:mm:ss');

    DateTime durationStart = dateFormat.parse(formattedTime);
    DateTime durationEnd = dateFormat.parse(formattedTime1);

    if (durationEnd.difference(durationStart).inHours < 0) {
      return (durationEnd.difference(durationStart).inHours * -1);
    }

    return durationEnd.difference(durationStart).inHours;
  }

  String thoiGianLamViec() {
    if (checkin == null || checkout == null) {
      return '';
    }
    String formatCheckIn = DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkin!));
    String formatCheckout = DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkout!));

    DateTime durationStart = DateFormat('hh:mm:ss').parse(formatCheckIn);
    DateTime durationEnd = DateFormat('hh:mm:ss').parse(formatCheckout);
    if (durationEnd.hour == 0) {}
    if (durationEnd.difference(durationStart).inHours < 0) {
      return (durationEnd.difference(durationStart))
          .toString()
          .substring(1, 10);
    }
    return (durationEnd.difference(durationStart)).toString().substring(0, 10);
  }

  String tachCheckIn() {
    if (checkin == null) {
      return '';
    }
    return DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkin!));
  }

  String tachCheckOut() {
    if (checkout == null) {
      return '';
    }

    return DateFormat.Hms()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkout!));
  }

  @override
  String toString() => events();

  factory TimeKeepData.fromJson(Map<String, dynamic> json) =>
      _$TimeKeepDataFromJson(json);

  Map<String, dynamic> toJson() => _$TimeKeepDataToJson(this);
}

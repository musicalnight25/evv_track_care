import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///////////////////////////////////////////////////////////////
//////////////////////[ FORMATTER ]/////////////////////////
///////////////////////////////////////////////////////////////
///
/// --- [ uses ]
/// format date, time, etc from one type to another
///
/// --- [ used_dependencies ]
/// --> intl:
///
///////////////////////////////////////////////////////////////

class Formatter {
  static String? stringFromDateTime(DateTime? timeStamp, {String format = 'dd MMM, yyyy'}) => timeStamp == null ? null : DateFormat(format).format(timeStamp);

  static String? stringFromTimeString(String? time, {String format = 'dd-MM-yyyy'}) {
    if (time == null) return null;
    DateTime timeStamp = DateTime.parse(time);
    return DateFormat(format).format(timeStamp);
  }

  static String? stringFromTimeOfDay(BuildContext context, {required TimeOfDay? time, bool hrs24 = false}) {
    if (time == null) return null;
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(time, alwaysUse24HourFormat: hrs24);
  }

  static TimeOfDay? timeOfDayFromString(String? time) {
    if (time == null) return null;
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  static String? get12HrsTimeFromString(BuildContext context, {required String? time}) {
    if (time == null) return null;
    final timeOfDay = timeOfDayFromString(time);
    return stringFromTimeOfDay(context, time: timeOfDay);
  }

  static DateTime? dateTimeFromString(String? date) {
    if (date == null) return null;
    return DateTime.tryParse(date);
  }

  static String? stringDateFromString(String? dateString, {String reqFormat = "yyyy-MM-dd", String resFormat = "yyyy-MM-dd"}) {
    if (dateString == null) return null;
    return stringFromDateTime(DateFormat(reqFormat).parse(dateString), format: resFormat);
  }

  static String? dateTimeFromStringddMMYY(
      {String? startTimeStr, String? endTimeStr}) {
    DateTime startTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(startTimeStr!);
    DateTime endTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(endTimeStr!);
    String timeRange = "${DateFormat("HH:mm").format(startTime)}-${DateFormat("HH:mm").format(endTime)}";
    return timeRange;
  }
}

import 'package:date_format/date_format.dart';

DateTime string2DateTime(String dateTime) => DateTime.parse(dateTime).toLocal();

extension DateTimeExtension on DateTime {
  String get yyyymmdd => formatDate(this, [yyyy, '-', mm, '-', dd]);

  String get yyyymmddhhmm => formatDate(this, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
}

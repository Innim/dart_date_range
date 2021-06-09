// ignore_for_file: avoid_print
import 'package:in_date_range/in_date_range.dart';

void main() {
  final today = DateRange.today();
  print('Today range: $today');

  final week = DateRange.week(DateTime(2021, 6, 9));
  print('Week that contains 2021/06/09 range: $week');

  final month = DateRange.month(DateTime(2021, 6, 9));
  print('Month that contains 2021/06/09 range: $month');

  final year = DateRange.year(DateTime(2021, 6, 9));
  print('Year that contains 2021/06/09 range: $year');

  final custom = DateRange(
    DateTime(2021, 6, 9, 18, 20),
    DateTime(2021, 6, 10, 17, 00),
  );
  print('Custom range: $custom');
}

import 'package:in_date_range/in_date_range.dart';
import 'package:test/test.dart';

void main() {
  group('equality', () {
    test('should return true for identical dates', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final end = start.add(const Duration(hours: 45, minutes: 10));
      final a = DateRange(start, end);
      final b = DateRange(start, end);

      expect(a == b, true);
    });

    test('should return true for same dates', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final a = DateRange(DateTime(2019, 12, 3, 18, 10, 30),
          start.add(const Duration(hours: 45, minutes: 10)));
      final b = DateRange(DateTime(2019, 12, 3, 18, 10, 30),
          start.add(const Duration(hours: 45, minutes: 10)));

      expect(a == b, true);
    });
  });

  test('day should return correct range', () {
    final start = DateTime(2019, 12, 3, 18, 10, 30);
    final range = DateRange.day(start);

    expect(range.start.isAtSameMomentAs(DateTime(2019, 12, 3)), true);
    expect(range.end.isAtSameMomentAs(DateTime(2019, 12, 4)), true);
  });

  test('week should return correct range', () {
    final start = DateTime(2019, 12, 3, 18, 10, 30);
    final range = DateRange.week(start);

    expect(range.start.isAtSameMomentAs(DateTime(2019, 12, 2)), true);
    expect(range.end.isAtSameMomentAs(DateTime(2019, 12, 9)), true);
  });

  test('week started from Sunday should return correct range', () {
    final start = DateTime(2019, 12, 3, 18, 10, 30);
    final range = DateRange.week(start, firstWeekday: DateTime.sunday);

    expect(range.start.isAtSameMomentAs(DateTime(2019, 12, 1)), true);
    expect(range.end.isAtSameMomentAs(DateTime(2019, 12, 8)), true);
  });

  test('month should return correct range', () {
    final start = DateTime(2019, 12, 3, 18, 10, 30);
    final range = DateRange.month(start);

    expect(range.start.isAtSameMomentAs(DateTime(2019, 12, 1)), true);
    expect(range.end.isAtSameMomentAs(DateTime(2020, 1, 1)), true);
  });

  test('day should return correct range', () {
    final start = DateTime(2019, 12, 3, 18, 10, 30);
    final range = DateRange.day(start);

    expect(range.start.isAtSameMomentAs(DateTime(2019, 12, 3)), true);
    expect(range.end.isAtSameMomentAs(DateTime(2019, 12, 4)), true);
  });

  test('today should return correct range', () {
    final now = DateTime.now();
    final range = DateRange.today();

    final expectedStart = DateTime(now.year, now.month, now.day);
    final expectedEnd = DateTime(now.year, now.month, now.day + 1);

    expect(range.start.isAtSameMomentAs(expectedStart), true);
    expect(range.end.isAtSameMomentAs(expectedEnd), true);
  });

  group('contains', () {
    test('should return true for date in range', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final end = start.add(const Duration(hours: 45, minutes: 10));
      final range = DateRange(start, end);

      expect(range.contains(start), true);
      expect(range.contains(start.add(const Duration(seconds: 1))), true);
      expect(range.contains(start.add(const Duration(hours: 1))), true);
      expect(range.contains(end.subtract(const Duration(seconds: 1))), true);
    });

    test('should return false for date out of range', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final end = start.add(const Duration(hours: 45, minutes: 10));
      final range = DateRange(start, end);

      expect(range.contains(end), false);
      expect(range.contains(end.add(const Duration(seconds: 1))), false);
      expect(range.contains(end.add(const Duration(days: 1))), false);
      expect(range.contains(start.add(const Duration(days: 3))), false);
      expect(range.contains(start.subtract(const Duration(seconds: 1))), false);
    });
  });

  group('includes()', () {
    test('should return true if whole range is in range', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final end = start.add(const Duration(hours: 45, minutes: 10));
      final range = DateRange(start, end);

      expect(range.includes(DateRange(start, end)), true);
      expect(
          range.includes(DateRange(
            start.add(const Duration(seconds: 1)),
            end,
          )),
          true);
      expect(
          range.includes(DateRange(
            start.add(const Duration(hours: 1)),
            end,
          )),
          true);
      expect(
          range.includes(DateRange(
            start,
            end.subtract(const Duration(seconds: 1)),
          )),
          true);
      expect(
          range.includes(DateRange(
            start.add(const Duration(days: 1)),
            end.subtract(const Duration(hours: 3)),
          )),
          true);
    });

    test('should return false if whole range is out of range', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final end = start.add(const Duration(hours: 45, minutes: 10));
      final range = DateRange(start, end);

      expect(
          range.includes(DateRange(
            end,
            end.add(const Duration(seconds: 1)),
          )),
          false);

      expect(
          range.includes(DateRange(
            end.add(const Duration(seconds: 1)),
            end.add(const Duration(days: 1)),
          )),
          false);

      expect(
          range.includes(DateRange(
            end.add(const Duration(days: 3)),
            end.add(const Duration(days: 10)),
          )),
          false);

      expect(
          range.includes(DateRange(
            start.subtract(const Duration(days: 1)),
            start.subtract(const Duration(seconds: 1)),
          )),
          false);
    });

    test('should return false if part of range is out of range', () {
      final start = DateTime(2019, 12, 3, 18, 10, 30);
      final end = start.add(const Duration(hours: 45, minutes: 10));
      final range = DateRange(start, end);

      expect(
          range.includes(DateRange(
            start,
            end.add(const Duration(seconds: 1)),
          )),
          false);

      expect(
          range.includes(DateRange(
            start.add(const Duration(hours: 1)),
            end.add(const Duration(days: 1)),
          )),
          false);

      expect(
          range.includes(DateRange(
            start.subtract(const Duration(days: 1)),
            end,
          )),
          false);

      expect(
          range.includes(DateRange(
            start.subtract(const Duration(days: 1)),
            end.subtract(const Duration(hours: 10)),
          )),
          false);

      expect(
          range.includes(DateRange(
            start.subtract(const Duration(days: 1)),
            end.add(const Duration(days: 1)),
          )),
          false);
    });
  });
}

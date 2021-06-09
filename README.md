# in_date_range

[![pub package](https://img.shields.io/pub/v/in_date_range)](https://pub.dartlang.org/packages/in_date_range)
[![innim lint](https://img.shields.io/badge/style-innim_lint-40c4ff.svg)](https://pub.dev/packages/innim_lint)
[![Dart](https://github.com/Innim/dart_date_range/actions/workflows/dart.yml/badge.svg?branch=main)](https://github.com/Innim/dart_date_range/actions/workflows/dart.yml)

Encapsulates a start and end DateTime that represent the range of dates.

## Usage

Create `DateRange` that contains information about a range of dates:

```dart
final range = DateRange(
    DateTime(2021, 6, 9, 18, 20),
    DateTime(2021, 6, 10, 17, 00),
);
```

You can easily create common ranges, such as:
```dart
// Today
final today = DateRange.today();

// Day, that contains specefied DateTime
final week = DateRange.day(DateTime(2021, 6, 9));

// Week, that contains specefied DateTime
final week = DateRange.week(DateTime(2021, 6, 9));

// Specify first wekkday if you need it
final weekFromSunday = DateRange.week(
    DateTime(2021, 6, 9), 
    firstWeekday: DateTime.sunday,
);

// Month, that contains specefied DateTime
final month = DateRange.month(DateTime(2021, 6, 9));

// Year, that contains specefied DateTime
final year = DateRange.year(DateTime(2021, 6, 9));
```

When you have `DateRange` instance, you can check if specified `DateTime` is in range:
```dart
final range = DateRange(
    DateTime(2021, 6, 9, 18, 20),
    DateTime(2021, 7, 20, 17, 00),
);
final date = DateTime(2021, 6, 11);

if (range.contains(date)) {
    print('Range contains $date');
}
```

And there is more, see the API documentation.
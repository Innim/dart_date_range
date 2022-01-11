import 'package:equatable/equatable.dart';
import 'package:in_date_utils/in_date_utils.dart';

/// Промежуток дат.
class DateRange extends Equatable {
  /// Дата начала промежутка (включая).
  final DateTime start;

  /// Дата окончания промежутка (исключая).
  final DateTime end;

  DateRange(this.start, this.end)
      : assert(start.isBefore(end)),
        super();

  @override
  List<Object> get props => [start, end];

  /// Создает промежуток в 1 день.
  ///
  /// За начало берется 00:00 часов указанного дня.
  DateRange.day(DateTime value)
      : this(DateUtils.startOfDay(value), DateUtils.startOfNextDay(value));

  /// Создает промежуток в 1 неделю.
  /// Creates 1 week range.
  ///
  /// For the start will be used 00:00 of the first day of the week,
  /// which contains [value].
  ///
  /// You can define first weekday (Monday, Sunday or Saturday) with
  /// parameter [firstWeekday]. It should be one of the constant values
  /// [DateTime.monday], ..., [DateTime.sunday].
  ///
  /// By default it's [DateTime.monday].
  DateRange.week(DateTime value, {int? firstWeekday})
      : this(DateUtils.firstDayOfWeek(value, firstWeekday: firstWeekday),
            DateUtils.firstDayOfNextWeek(value, firstWeekday: firstWeekday));

  /// Создает промежуток в 1 месяц.
  ///
  /// За начало берется 00:00 часов первого дня месяца, к которому относится [value].
  DateRange.month(DateTime value)
      : this(DateUtils.firstDayOfMonth(value),
            DateUtils.firstDayOfNextMonth(value));

  /// Создает промежуток в 1 год.
  ///
  /// За начало берется 00:00 часов первого дня года, к которому относится [value].
  DateRange.year(DateTime value)
      : this(DateUtils.firstDayOfYear(value),
            DateUtils.firstDayOfNextYear(value));

  /// Создает промежуток в 1 день - сегодня.
  ///
  /// См. [DateRange.day].
  DateRange.today() : this.day(DateTime.now());

  /// Проверяет, содержится ли переданная дата в промежутке.
  bool contains(DateTime value) {
    return value.compareTo(start) >= 0 && value.isBefore(end);
  }

  /// Returns `true` if the whole [range] is in current range.
  bool includes(DateRange range) =>
      range.start.compareTo(start) >= 0 && range.end.compareTo(end) <= 0;

  /// Возвращает [DateTime] для каждого для в заданном промежутке.
  ///
  /// [DateRange.start] включительно,
  /// [DateRange.end] исключительно.
  Iterable<DateTime> daysInRange(DateRange range) {
    return DateUtils.generateWithDayStep(range.start, range.end);
  }

  @override
  String toString() {
    return 'DateRange{start: $start, end: $end}';
  }
}

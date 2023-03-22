import 'package:intl/intl.dart';

extension DurationExtension on Duration {
  String toTime() {
    return this.toString().substring(2, 7);
  }
}

extension DateHelperExtension on DateTime {
  int dateDifference(DateTime secondDate) {
    return DateTime.utc(this.year, this.month, this.day).difference(DateTime.utc(secondDate.year, secondDate.month, secondDate.day)).inDays;
  }

  DateTime addDate(int days) {
    return DateTime(this.year, this.month, this.day).add(Duration(days: days));
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
  bool isToday( ) {
    return this.year == DateTime.now().year && this.month == DateTime.now().month && this.day == DateTime.now().day;
  }

  bool isInRange(DateTime startDate, DateTime endDate) {
    return (this.isAfter(startDate) || this.isSameDate(startDate)) && (this.isBefore(endDate) || this.isSameDate(endDate));
  }

  String getGregorianWeekDayAndDate() {
    final f = DateFormat('EEEE, MMM d');

    return f.format(this);
  }

  String formatDate({String? formatType}) {
    return DateFormat(formatType ?? 'dd MM yyyy').format(this);
  }

  String formatShortDate({String? formatType}) {
    return DateFormat(formatType ?? 'dd MM yy').format(this);
  }

  String formatTime({String? formatType}) {
    return DateFormat(formatType ?? 'HH:mm').format(this);
  }
}

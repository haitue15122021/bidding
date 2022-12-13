import 'day_of_week_option.dart';

class OpenTimeInDay {
  final int openHourFrom;
  final int openMinuteFrom;
  final DayPeriod dayPeriodFrom;
  final int openHourTo;
  final int openMinuteTo;
  final DayPeriod dayPeriodTo;

  const OpenTimeInDay({
    this.openHourFrom,
    this.openMinuteFrom,
    this.openHourTo,
    this.openMinuteTo,
    this.dayPeriodFrom,
    this.dayPeriodTo
  });
}



import 'package:equatable/equatable.dart';
import 'package:restaurant_management/core/core.dart';
import 'day_of_week_option.dart';
import 'open_time_in_day.dart';


class RestaurantEntity extends Equatable{
  final String name;
  final String operatingHours;

  const RestaurantEntity({
    this.name,
    this.operatingHours,
  });

  @override
  List<Object> get props => [name,operatingHours];

}

extension RestaurantEntityExt on RestaurantEntity {
  bool  isOpen({DateTime currentTime}) => _isOpen(currentTime: currentTime);
  List<String> get openTimesInWeek => _getOpenTimesInWeek();

  bool _isOpen({DateTime currentTime}) {
    currentTime ??= DateTime.now();

    final int today =currentTime.weekday;

    final DayOfWeekOption dayOfWeekOptionForToday = numberOrderToDayOfWeekMap[today];

    final OpenTimeInDay openTimeForToday = _getOpenTimesInWeekMap()[dayOfWeekOptionForToday];
    if (openTimeForToday == null) {
      return false;
    }
    final int currentHour = currentTime.hour;
    final int currentMinute = currentTime.minute;

    if (_isCurrentTimeBetweenOpenFromAndOpenTo(
      openTimeForToday: openTimeForToday,
      currentHour: currentHour,
      currentMinute: currentMinute,
    )) {
      return true;
    }

    return false;
  }

  bool _isCurrentTimeBetweenOpenFromAndOpenTo(
      {OpenTimeInDay openTimeForToday, currentHour, currentMinute}) {
    const numberMinuteInAHour = 60;
    int openHourFrom = openTimeForToday.openHourFrom;

    if(openTimeForToday.dayPeriodFrom==DayPeriod.pm && openHourFrom!=twelveOClock){
      openHourFrom+=twelveOClock;
    }

    int openHourTo = openTimeForToday.openHourTo;
    if(openTimeForToday.dayPeriodTo==DayPeriod.pm && openHourTo!=twelveOClock){
      openHourTo+=twelveOClock;
    }
    ///Because No restaurant will remain open after 11:59PM, we don't need to handle case 12h am

    final int currentTime = currentHour * numberMinuteInAHour + currentMinute;
    final int startTime = openHourFrom * numberMinuteInAHour + openTimeForToday.openMinuteFrom;
    final int endTime = openHourTo * numberMinuteInAHour + openTimeForToday.openMinuteTo;

    final bool  isCurrentTimeBetweenStartTimeAndEndTime = currentTime>=startTime && currentTime<=endTime;
    return isCurrentTimeBetweenStartTimeAndEndTime;
  }

  List<String> _getOpenTimesInWeek() {
    List<String> openTimesInWeek = [];
    Map<DayOfWeekOption, OpenTimeInDay> openTimesInWeekMap = _getOpenTimesInWeekMap();

    numberOrderToDayOfWeekMap.forEach((key, value) {
      final DayOfWeekOption dayOfWeek = value;
      final OpenTimeInDay openTimeInDay = openTimesInWeekMap[dayOfWeek];
      if (openTimeInDay != null) {
        StringBuffer openTimeInfoBuffer = StringBuffer();
        openTimeInfoBuffer.write('${dayOfWeek.toShortString()} ** ');


        openTimeInfoBuffer.write('${openTimeInDay.openHourFrom}');
        openTimeInfoBuffer.write(':');
        openTimeInfoBuffer.write('${openTimeInDay.openMinuteFrom < 10 ? '0${openTimeInDay.openMinuteFrom}' : openTimeInDay.openMinuteFrom} ');
        openTimeInfoBuffer.write('${openTimeInDay.dayPeriodFrom.toShortString()}');
        openTimeInfoBuffer.write(' - ');

        openTimeInfoBuffer.write('${openTimeInDay.openHourTo}');
        openTimeInfoBuffer.write(':');
        openTimeInfoBuffer.write('${openTimeInDay.openMinuteTo < 10 ? '0${openTimeInDay.openMinuteTo}' : openTimeInDay.openMinuteTo} ');
        openTimeInfoBuffer.write('${openTimeInDay.dayPeriodTo.toShortString()}');


        openTimesInWeek.add(openTimeInfoBuffer.toString());
      }
    });

    return openTimesInWeek;
  }

  Map<DayOfWeekOption, OpenTimeInDay> _getOpenTimesInWeekMap() {
    if (operatingHours == null || operatingHours.trim().isEmpty) {
      return {};
    }
    Map<DayOfWeekOption, OpenTimeInDay> openTimesInWeek = {};
    RegExp regExpToGetTimePart = RegExp(
      r'\d{1,2}:\d{2} (?:a|p)m - \d{1,2}:\d{2} (?:a|p)m',
      caseSensitive: false,
      multiLine: false,
    );
    RegExp regExpToGetDayPeriods = RegExp(
      r'(?:a|p)m',
      caseSensitive: false,
      multiLine: false,
    );
    RegExp regExpToGetTimeWithoutDayPeriods = RegExp(
      r'\d{1,2}:\d{2}',
      caseSensitive: false,
      multiLine: false,
    );
    List<String> openTimes = operatingHours.split('/');

    openTimes.forEach((openTime) {
      _addOpenTimeWithEachTime(
        openTime: openTime,
        openTimesInWeek: openTimesInWeek,
        regExpToGetTimePart: regExpToGetTimePart,
        regExpToGetDayPeriods: regExpToGetDayPeriods,
        regExpToGetTimeWithoutDayPeriods: regExpToGetTimeWithoutDayPeriods,
      );
    });
    return openTimesInWeek;
  }

  void _addOpenTimeWithEachTime(
      {String openTime,
      openTimesInWeek,
      regExpToGetTimePart,
      regExpToGetDayPeriods,
      regExpToGetTimeWithoutDayPeriods}) {
    String timePart = regExpToGetTimePart.stringMatch(openTime).trim();
    int indexOfTimePart = openTime.indexOf(timePart);
    String dayOfWeekPart = openTime.substring(0, indexOfTimePart - 1).trim();

    OpenTimeInDay openTimeInDay = _getOpenTimeInDay(
      timePart: timePart,
      regExpToGetDayPeriods: regExpToGetDayPeriods,
      regExpToGetTimeWithoutDayPeriods: regExpToGetTimeWithoutDayPeriods,
    );

    List<String>  days = dayOfWeekPart.split(',');
    days.forEach((day) {
      _addOpenTimeWithEachDay(
        day: day,
        openTimesInWeek: openTimesInWeek,
        openTimeInDay: openTimeInDay,
      );
    });
  }

  void _addOpenTimeWithEachDay({
    day,
    openTimesInWeek,
    OpenTimeInDay openTimeInDay,
  }) {
    day = day.trim();
    if (day.contains('-')) {
      DayOfWeekOption dayFrom =
          DayOfWeekOptionExt.getEnumFromValue(day.split('-')[0].trim());
      DayOfWeekOption dayTo = DayOfWeekOptionExt.getEnumFromValue(day.split('-')[1].trim());

      openTimesInWeek.putIfAbsent(dayFrom, () => openTimeInDay);
      openTimesInWeek.putIfAbsent(dayTo, () => openTimeInDay);

      int numberOrder = dayOfWeekToNumberOrderMap[dayFrom] + 1;
      while (numberOrder < dayOfWeekToNumberOrderMap[dayTo]) {
        openTimesInWeek.putIfAbsent(
            numberOrderToDayOfWeekMap[numberOrder], () => openTimeInDay);
        numberOrder++;
      }
    } else {
      openTimesInWeek.putIfAbsent(
          DayOfWeekOptionExt.getEnumFromValue(day), () => openTimeInDay);
    }
  }

  OpenTimeInDay _getOpenTimeInDay(
      {timePart, regExpToGetDayPeriods, regExpToGetTimeWithoutDayPeriods}) {
    List<String> times = timePart.split('-');
    String openFrom = times[0].trim();
    String openTo = times[1].trim();

    String dayPeriodFrom = regExpToGetDayPeriods.stringMatch(openFrom).trim();
    openFrom = regExpToGetTimeWithoutDayPeriods.stringMatch(openFrom);
    int openHourFrom = int.tryParse(openFrom.split(':')[0]);
    int openMinuteFrom = int.tryParse(openFrom.split(':')[1]);


    String dayPeriodTo = regExpToGetDayPeriods.stringMatch(openTo).trim();
    openTo = regExpToGetTimeWithoutDayPeriods.stringMatch(openTo);
    int openHourTo = int.tryParse(openTo.split(':')[0]);
    int openMinuteTo = int.tryParse(openTo.split(':')[1]);


    OpenTimeInDay openTimeInDay = OpenTimeInDay(
        openHourFrom: openHourFrom,
        openMinuteFrom: openMinuteFrom,
        dayPeriodFrom: DayPeriodExt.getEnumFromValue(dayPeriodFrom),
        openHourTo: openHourTo,
        openMinuteTo: openMinuteTo,
        dayPeriodTo: DayPeriodExt.getEnumFromValue(dayPeriodTo)

    );

    return openTimeInDay;
  }
}

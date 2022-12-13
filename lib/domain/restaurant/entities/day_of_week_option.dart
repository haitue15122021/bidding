enum DayOfWeekOption {
  Mon,
  Tue,
  Wed,
  Thu,
  Fri,
  Sat,
  Sun,
}

extension DayOfWeekOptionExt on DayOfWeekOption {
  static DayOfWeekOption getEnumFromValue(String value) {
    return DayOfWeekOption.values.firstWhere(
            (element) => element.toString() == 'DayOfWeekOption.$value');
  }
  String toShortString() {
    return toString().split('.').last;
  }
}

const Map<DayOfWeekOption, int> dayOfWeekToNumberOrderMap = {
  DayOfWeekOption.Mon: 1,
  DayOfWeekOption.Tue: 2,
  DayOfWeekOption.Wed: 3,
  DayOfWeekOption.Thu: 4,
  DayOfWeekOption.Fri: 5,
  DayOfWeekOption.Sat: 6,
  DayOfWeekOption.Sun: 7
};

const Map<int, DayOfWeekOption> numberOrderToDayOfWeekMap = {
  1: DayOfWeekOption.Mon,
  2: DayOfWeekOption.Tue,
  3: DayOfWeekOption.Wed,
  4: DayOfWeekOption.Thu,
  5: DayOfWeekOption.Fri,
  6: DayOfWeekOption.Sat,
  7: DayOfWeekOption.Sun
};


enum DayPeriod{
  am,
  pm
}

extension DayPeriodExt on DayPeriod {
  static DayPeriod getEnumFromValue(String value) {
    return DayPeriod.values.firstWhere(
            (element) => element.toString() == 'DayPeriod.$value');
  }
  String toShortString() {
    return toString().split('.').last;
  }
}
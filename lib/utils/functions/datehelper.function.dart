class DateHelper {
  final DateTime date;
  DateHelper({required this.date});

  String get readableDate => "$getDay $getDate $getMonth $getYear";

  String get readableDateTime =>
      "$getMonth $getDate, $getYear ${date.hour}${date.minute} hrs";

  String get getDay =>
      date.weekday == 7 ? _days[0].day : _days[date.weekday].day;

  int get getDate => date.day;

  String get getMonth => _months[date.month - 1].month;

  String get getYear => "${date.year}";

  @override
  String toString() {
    return "DateHelper(date: $date)";
  }
}

class Day {
  String day;
  Day(this.day);
}

class Month {
  String month;
  Month(this.month);
}

List<Month> _months = [
  Month("January"),
  Month("February"),
  Month("March"),
  Month("April"),
  Month("May"),
  Month("June"),
  Month("July"),
  Month("August"),
  Month("September"),
  Month("October"),
  Month("November"),
  Month("December")
];
List<Day> _days = [
  Day("Sunday"),
  Day("Monday"),
  Day("Tuesday"),
  Day("Wednesday"),
  Day("Thursday"),
  Day("Friday"),
  Day("Saturday")
];

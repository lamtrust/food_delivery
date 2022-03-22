String generateVendorReference() {
  DateTime now = DateTime.now();
  String day = "${now.day}".length == 1 ? "0${now.day}" : "${now.day}";
  String month = "${now.month}".length == 1 ? "0${now.month}" : "${now.month}";
  String year = "${now.year}";
  String hour = "${now.hour}".length == 1 ? "0${now.hour}" : "${now.hour}";
  String minute =
      "${now.minute}".length == 1 ? "0${now.minute}" : "${now.minute}";
  String seconds =
      "${now.second}".length == 1 ? "0${now.second}" : "${now.second}";
  String reference =
      "TM|$day$month$year|$hour$minute$seconds|${now.millisecondsSinceEpoch}";
  return reference;
}

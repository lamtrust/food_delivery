import 'package:money_formatter/money_formatter.dart';

extension Money on double {
  MoneyFormatterOutput get money => MoneyFormatter(amount: this).output;
}

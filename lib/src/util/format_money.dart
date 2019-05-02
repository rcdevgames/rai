import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class FormatMoney {
  String format(num value, [bool withSymbol]) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: value.toDouble(),
        settings: MoneyFormatterSettings(
            symbol: '£',
            thousandSeparator: ',',
            decimalSeparator: '.',
            symbolAndNumberSeparator: ' ',
            compactFormatType: CompactFormatType.short
        )
    );
    if (withSymbol == null) return fmf.output.compactNonSymbol;
    return fmf.output.compactSymbolOnLeft;
  }
}

final formatMoney = new FormatMoney();
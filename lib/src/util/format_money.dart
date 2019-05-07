import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class FormatMoney {
  String format(num value, [bool withSymbol]) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: value.toDouble(),
        settings: MoneyFormatterSettings(
            symbol: '£',
            thousandSeparator: ',',
            decimalSeparator: '.',
            fractionDigits: 2,
            symbolAndNumberSeparator: ' ',
            compactFormatType: CompactFormatType.short
        )
    );
    String money;
    if (withSymbol == null) {
      money = fmf.output.nonSymbol;
    }else{
      money = fmf.output.symbolOnLeft;
    }
    
    return money.substring(0, money.length-3);
  }
}

final formatMoney = new FormatMoney();
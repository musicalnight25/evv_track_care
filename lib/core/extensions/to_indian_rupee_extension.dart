import 'package:intl/intl.dart';

var _format = NumberFormat.currency(
  name: "",
  locale: 'HI',
  decimalDigits: 2,
  // change it to get decimal places
  symbol: '₹ ',
);

extension IndianCurrencyFormatt on num {
  String get toIndianRupee {
    return _format.format(this);
  }
}

extension IndianCurrencyFormattForInt on int {
  String get toIndianRupee {
    return _format.format(this);
  }
}

extension IndianCurrencyFormattForString on String {
  String get toIndianRupee {
    return _format.format(num.parse(this));
  }
}

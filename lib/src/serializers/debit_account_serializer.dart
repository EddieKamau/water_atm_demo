import 'package:water_atm_demo/water_atm_demo.dart';

class DebitAccountSerializer extends Serializable {
  late String accountNo;
  late double amount;

  @override
  Map<String, dynamic>? asMap()=> {
    'accountNo': accountNo,
    'amount': amount,
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    accountNo = object['accountNo'].toString();
    amount = double.parse(object['amount'].toString());
  }

  @override
  void read(Map<String, dynamic> object, {Iterable<String>? accept, Iterable<String>? ignore, Iterable<String>? reject, Iterable<String>? require}) {
    Iterable<String>? _reject = reject;
    try {
      double.parse(object['amount'].toString());
    } catch (e) {
      _reject = ['amount'];
    }


    super.read(object, accept: accept, ignore: ignore, reject: _reject, require: require);
  }
  
}
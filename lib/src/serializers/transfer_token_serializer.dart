import 'package:water_atm_demo/water_atm_demo.dart';

class TransferTokenSerilizer extends Serializable {
  late String from;
  late String to;
  late double amount;

  @override
  Map<String, dynamic>? asMap()=> {
    'from': from,
    'to': to,
    'amount': amount,
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    from = object['from'].toString();
    to = object['to'].toString();
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
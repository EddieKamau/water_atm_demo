import 'package:water_atm_demo/water_atm_demo.dart';

class DepositAccountSerializer extends Serializable {
  late String receiptNo;
  late String accountReference;
  late String paymentMethod;
  late double amount;
  late Map<String, dynamic> metadata;

  @override
  Map<String, dynamic>? asMap()=> {
    'receiptNo': receiptNo,
    'accountReference': accountReference,
    'paymentMethod': paymentMethod,
    'amount': amount,
    'metadata': metadata
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    receiptNo = object['receiptNo'].toString();
    accountReference = object['accountReference'].toString();
    paymentMethod = object['paymentMethod'].toString();
    amount = double.parse(object['amount'].toString());
    metadata = object;
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
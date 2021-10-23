import 'package:water_atm_demo/src/models/model.dart';

class TransactionActivityModel  extends Model{
  TransactionActivityModel({
    this.accountNo, this.amount, this.transactionId, this.metadata, this.paymentMethod,
    PaymentMethod? paymentMethodEnum, DateTime? dateTime
  }):super('transactions'){
    paymentMethod ??= paymentMethodEnum?.value;
    this.dateTime = dateTime ?? DateTime.now();
  }

  String? paymentMethod;
  String? transactionId;
  double? amount;
  late DateTime dateTime;
  String? accountNo;
  Map<String, dynamic>? metadata;
}

enum PaymentMethod{mpesa, bank}

extension PaymentMethodValue on PaymentMethod{
  String get value{
    return toString().split('.')[1];
  }
}

PaymentMethod? paymentMethodFromString(String val){
  switch (val.toLowerCase()) {
    case 'mpesa':
      return PaymentMethod.mpesa;
    case 'bank':
      return PaymentMethod.bank;
    default:
  }
}
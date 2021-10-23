import 'package:water_atm_demo/src/models/model.dart';

class TransferActivityModel  extends Model{
  TransferActivityModel({
    this.fromAccount, this.toAccount, this.amount,
    DateTime? dateTime
  }):super('transfer_activities'){
    this.dateTime = dateTime ?? DateTime.now();
  }

  String? fromAccount;
  String? toAccount;
  double? amount;
  late DateTime dateTime;
}
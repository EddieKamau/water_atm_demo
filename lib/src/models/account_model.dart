import 'package:water_atm_demo/src/models/model.dart';

class AccountModel  extends Model{
  AccountModel({this.accountNo, this.balance}):super('accounts');
  String? accountNo;
  double? balance;

  Future<ModelResponse> saveOrUpdate(String accountNo, double amount, {bool credit = true})async{
    // check if exist
    final bool _exist = await exists(where.eq('accountNo', accountNo));
    if(_exist){ // update account balance
      final double _amount = amount * (credit ? 1 : -1);
      
      // if debit, chech if balance is greter than amount being debited
      if(!credit){
        final _accRes = await findOneBy(where.eq('accountNo', accountNo));
        if((_accRes.body['balance'] as double) >= amount){
          return await findAndModify(
            selector: where.eq('accountNo', accountNo),
            modifier: modify.inc('balance', _amount)
          );
        }else{
          return ModelResponse(statusCode: 1, body: {"message": 'insufficient balance!'});
        }

      }else{
        return await findAndModify(
          selector: where.eq('accountNo', accountNo),
          modifier: modify.inc('balance', _amount)
        );
      }

    }else{ // create acc
      if(credit){
        final AccountModel accountModel = AccountModel(accountNo: accountNo, balance: amount);
        return await accountModel.save();
      }else{
        return ModelResponse(statusCode: 1, body: {'message': 'Invalid account!'});
      }
    }

  }

}

class AccountActivityModel  extends Model{
  AccountActivityModel({
    this.accountNo, this.amount, this.metadata, this.activityType,
    ActivityType? activityTypeEnum, DateTime? dateTime
  }):super('account_activities'){
    activityType ??= activityTypeEnum?.value;
    this.dateTime = dateTime ?? DateTime.now();
  }

  String? accountNo;
  String? activityType;
  double? amount;
  late DateTime dateTime;
  Map<String, dynamic>? metadata;
}

enum ActivityType{
  debit, credit
}

extension ActivityTypeValue on ActivityType{
  String get value{
    return toString().split('.')[1];
  }
}


ActivityType? activityTypeFromString(String val){
  switch (val.toLowerCase()) {
    case 'debit':
      return ActivityType.debit;
    case 'credit':
      return ActivityType.credit;
    default:
  }
}
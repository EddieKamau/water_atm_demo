import 'package:water_atm_demo/src/models/account_model.dart';
import 'package:water_atm_demo/src/models/model.dart';
import 'package:water_atm_demo/src/models/transfer_model.dart';

class TransferTokensModule {
  TransferTokensModule({
    required this.fromAccountNo, required this.toAccountNo, required this.amount
  });

  String fromAccountNo;
  String toAccountNo;
  double amount;

  String? _transferActivityId;

  Future<ModelResponse> process()async{
    final _res = await updateAccounts();
    // if updating accounts is successfull, save activities
    if(_res.statusCode ==0){
      await saveTransferActivityModel();
      await updateAccountActivities();
    }
    return _res;

  }

  // debit fromAcc credittoAcc
  Future<ModelResponse> updateAccounts()async{
    final AccountModel _accountModel = AccountModel();
    late ModelResponse response;
    
    // debit account
    final _res = await _accountModel.saveOrUpdate(fromAccountNo, amount, credit: false);

    // if debit succes continue to credit
    if(_res.statusCode == 0){
      // credit account
      response = await _accountModel.saveOrUpdate(toAccountNo, amount, credit: true);
    }else{
      response = _res;
    }

    return response;    

  }

  // save TransferActivityModel
  Future saveTransferActivityModel()async{
    final TransferActivityModel activityModel = TransferActivityModel(
      fromAccount: fromAccountNo, toAccount: toAccountNo, amount: amount
    );
    
    await activityModel.save();

    // update _transferActivityId
    _transferActivityId = activityModel.id;

  }

  // update account activities
  Future updateAccountActivities()async{
    // save debit activity
    final AccountActivityModel debitActivityModel = AccountActivityModel(
      accountNo: fromAccountNo, amount: amount, activityTypeEnum: ActivityType.debit,
      metadata: {
        if(_transferActivityId != null) 'transferActivityId': _transferActivityId,
      }
    );

    await debitActivityModel.save();

    // save credit activity
    final AccountActivityModel creditActivityModel = AccountActivityModel(
      accountNo: toAccountNo, amount: amount, activityTypeEnum: ActivityType.credit,
      metadata: {
        if(_transferActivityId != null) 'transferActivityId': _transferActivityId,
      }
    );

    await creditActivityModel.save();
  }


  
}
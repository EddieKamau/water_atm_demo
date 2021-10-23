import 'package:water_atm_demo/src/models/account_model.dart';
import 'package:water_atm_demo/src/models/model.dart';
import 'package:water_atm_demo/src/models/transaction_activity_model.dart';

class DepositAccountModule {
  DepositAccountModule({
    required this.transactionId, required this.accountNo, required this.amount, 
    required this.paymentMethod, this.metadata
  });

  String transactionId;
  String accountNo;
  String paymentMethod;
  double amount;
  Map<String, dynamic>? metadata;
  
  String? _transactionActivityId;

  // process
  Future<ModelResponse> process()async{
    await saveTransaction();
    final _res = await creditAccount();
    if(_res.statusCode ==0){
      await saveAccountActivity();
    }
    return _res;
  }



  // save transaction activity
  Future saveTransaction()async{
    final TransactionActivityModel transactionModel = TransactionActivityModel(
      accountNo: accountNo, amount: amount, transactionId: transactionId, 
      paymentMethod: paymentMethod, metadata: metadata
    );

    await transactionModel.save();

    // update _transactionActivityId;
    _transactionActivityId = transactionModel.id;

  }

  // credit account
  Future<ModelResponse> creditAccount()async{
    final AccountModel _accountModel = AccountModel();
    
    // credit account
    return await _accountModel.saveOrUpdate(accountNo, amount, credit: true);

  }

  // save account activity
  Future saveAccountActivity()async{
    final AccountActivityModel activityModel = AccountActivityModel(
      accountNo: accountNo, amount: amount, activityTypeEnum: ActivityType.credit,
      metadata: {
        'transactionId': transactionId,
        if(_transactionActivityId != null) 'transactionActivityId': _transactionActivityId,
      }
    );

    await activityModel.save();
  }
  

}
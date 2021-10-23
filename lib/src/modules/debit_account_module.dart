import 'package:water_atm_demo/src/models/account_model.dart';
import 'package:water_atm_demo/src/models/model.dart';

class DebitAccountModule {
  DebitAccountModule({required this.accountNo, required this.amount});

  String accountNo;
  double amount;

  Future<ModelResponse> process()async{
    final ModelResponse _res = await debitAccount();
    // if success save activity
    if(_res.statusCode ==0){
      await saveAccountActivity();
    }
    return _res;
    
  }

  // update account
  Future<ModelResponse> debitAccount()async{
    final AccountModel _accountModel = AccountModel();
    
    // debit account
    return await _accountModel.saveOrUpdate(accountNo, amount, credit: false);

  }

  // save account activity
  Future saveAccountActivity()async{
    final AccountActivityModel activityModel = AccountActivityModel(
      accountNo: accountNo, amount: amount, activityTypeEnum: ActivityType.debit,
    );

    await activityModel.save();
  }
  
}
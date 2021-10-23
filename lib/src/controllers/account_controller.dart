import 'package:phantom_model_manager/phantom_model_manager.dart';
import 'package:water_atm_demo/src/models/account_model.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

class AccountController extends ResourceController {
  final AccountModel accountModel = AccountModel();
  
  // get all
  @Operation.get()
  Future<Response> fetchAccounts({@Bind.query('limit') int limit = 100, @Bind.query('search') String? search})async{
    SelectorBuilder _selector = where.limit(limit);
    if (search != null && search.isNotEmpty) {
      _selector = where
                    .limit(limit)
                    .match('accountNo', search);
    }

    final res = await accountModel.find(_selector);

    if(res.statusCode == 0){
      return ProcessResponse(
        responseType: ResponseType.success,
        body: serializedBody(res.body)
      ).httpResponse;
    }else{
      return ProcessResponse(
        responseType: ResponseType.failed,
        body: serializedBody(res.body)
      ).httpResponse;
    }
  }

  // get one
  @Operation.get('accountNo')
  Future<Response> fetchAccountDetails({@Bind.path('accountNo') String accountNo =''})async{
    final SelectorBuilder _selector = where.eq('accountNo', accountNo);

    final res = await accountModel.findOneBy(_selector);

    if(res.statusCode == 0){
      return ProcessResponse(
        responseType: ResponseType.success,
        body: serializedBody(res.body)
      ).httpResponse;
    }else{
      return ProcessResponse(
        responseType: ResponseType.failed,
        body: serializedBody(res.body)
      ).httpResponse;
    }


  }
    
}

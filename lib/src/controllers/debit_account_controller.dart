import 'package:water_atm_demo/src/modules/debit_account_module.dart';
import 'package:water_atm_demo/src/serializers/debit_account_serializer.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

class DebitAccountController extends ResourceController {
  
  @Operation.post()
  Future<Response> debitAccount({@Bind.body(require: ['accountNo', 'amount']) DebitAccountSerializer? serilizer})async{
    final DebitAccountModule debitAccountModule = DebitAccountModule(
      accountNo: serilizer!.accountNo,
      amount: serilizer.amount,
    );

    final res = await debitAccountModule.process();

    if(res.statusCode == 0){
      return ProcessResponse(
        responseType: ResponseType.success,
        body: {'message': 'Account debited!'}
      ).httpResponse;
    }else{
      return ProcessResponse(
        responseType: ResponseType.failed,
        body: serializedBody(res.body)
      ).httpResponse;
    }
    
  }

}
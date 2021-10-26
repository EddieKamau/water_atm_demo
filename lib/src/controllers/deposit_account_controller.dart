import 'package:water_atm_demo/src/modules/deposit_account_module.dart';
import 'package:water_atm_demo/src/serializers/deposit_account_serializer.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

import 'utils/response_schemas.dart';

class DepositAccountCotroller extends ResourceController {

  @Operation.post()
  Future<Response> depositToAccount({
    @Bind.body(require: ['receiptNo', 'amount', 'accountReference', 'paymentMethod']) 
    DepositAccountSerializer? serilizer
  })async{
    final DepositAccountModule depositAccountModule = DepositAccountModule(
      transactionId: serilizer!.receiptNo,
      accountNo: serilizer.accountReference,
      amount: serilizer.amount,
      paymentMethod: serilizer.paymentMethod.toLowerCase(),
      metadata: serilizer.asMap(),
    );

    final res = await depositAccountModule.process();

    if(res.statusCode == 0){
      return ProcessResponse(
        responseType: ResponseType.success,
        body: {'message': 'Deposit success!'}
      ).httpResponse;
    }else{
      return ProcessResponse(
        responseType: ResponseType.failed,
        body: {'message': 'Deposit failed!', 'reason': res.body}
      ).httpResponse;
    }
    
  }
  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation? operation) {
    switch (operation) {
      case Operation.post():
        return responseSchema;
      default:
      return super.documentOperationResponses(context, operation);
    }
  }
}

Map<String, APIResponse> get responseSchema =>{
  ...successfulResponseSchema(
    body: APISchemaObject.object({
      'message': APISchemaObject.string()
    })
  ),
  ...failedResponseSchema(failed: true),
  ...unauthorizedSchema(),
  ...forbiddenSchema(),
  // ...notFoundSchema(resourceNotFound: true),
  ...mehodNotAllowedSchema(),
  ...serverErrorSchema(),
};
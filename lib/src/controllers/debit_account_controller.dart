import 'package:water_atm_demo/src/controllers/utils/response_schemas.dart';
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
  ...failedResponseSchema(failed: true, warning: true),
  ...unauthorizedSchema(),
  ...forbiddenSchema(),
  // ...notFoundSchema(resourceNotFound: true),
  ...mehodNotAllowedSchema(),
  ...serverErrorSchema(),
};
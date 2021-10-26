import 'package:water_atm_demo/src/models/account_model.dart';
import 'package:water_atm_demo/src/models/model.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

import 'utils/response_schemas.dart';

class AccountActivitiesController extends ResourceController {
  final AccountActivityModel activityModel = AccountActivityModel();
  
  // get all
  @Operation.get()
  Future<Response> fetchAccountActivities({@Bind.query('limit') int limit = 100, @Bind.query('search') String? search})async{
    SelectorBuilder _selector = where.limit(limit);
    if (search != null && search.isNotEmpty) { 
      _selector = where.limit(limit)
                    .match('accountNo',  search)
                    ..or(where.match('activityType',  search));
    }

    final res = await activityModel.find(_selector);

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

  // get by account
  @Operation.get('accountNo')
  Future<Response> fetchAccountActivityByAccount({@Bind.path('accountNo') String accountNo =''})async{
    final SelectorBuilder _selector = where.eq('accountNo', accountNo);

    final res = await activityModel.find(_selector);

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

  @override
  String? documentOperationDescription(APIDocumentContext context, Operation? operation) {
    switch (operation) {
      case Operation.get():
        return "Fecth all account activities for all accounts";
      case Operation.get('accountNo'):
        return "Fecth all account activities for the 'accountNo'";
      default:
      return super.documentOperationDescription(context, operation);
    }
    
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation? operation) {
    switch (operation) {
      case Operation.get():
      case Operation.get('accountNo'):
        return responseSchema;
      default:
      return super.documentOperationResponses(context, operation);
    }
  }
}

Map<String, APIResponse> get responseSchema =>{
  ...successfulResponseSchema(
    body: APISchemaObject.array(
      ofSchema: APISchemaObject.object({
        "accountNo": APISchemaObject.string(),
        "activityType": APISchemaObject.string(),
        "amount": APISchemaObject.number(),
        "dateTime": APISchemaObject.string(),
        "metadata": APISchemaObject.object({}),
      })
    )
  ),
  ...failedResponseSchema(),
  ...unauthorizedSchema(),
  ...forbiddenSchema(),
  ...notFoundSchema(resourceNotFound: true),
  ...mehodNotAllowedSchema(),
  ...serverErrorSchema(),
};

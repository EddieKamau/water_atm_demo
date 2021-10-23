import 'package:water_atm_demo/src/models/account_model.dart';
import 'package:water_atm_demo/src/models/model.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

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
}
import 'package:phantom_model_manager/phantom_model_manager.dart';
import 'package:water_atm_demo/src/models/transfer_model.dart';
import 'package:water_atm_demo/src/modules/transfer_tokens_module.dart';
import 'package:water_atm_demo/src/serializers/transfer_token_serializer.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

class TransferTokenController extends ResourceController {

  final TransferActivityModel transferTokenModel = TransferActivityModel();
  // get transfered token activities
  @Operation.get()
  Future<Response> fetchTransferedTokensActivities({
    @Bind.query('limit') int limit = 100, @Bind.query('search') String? search
  })async{
    SelectorBuilder _selector = where.limit(limit);
    if (search != null && search.isNotEmpty) { 
      _selector = where.limit(limit)
                    .match('fromAccount',  search)
                    .or(where.match('toAccount',  search));
    }

    final res = await transferTokenModel.find(_selector);

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
  

  @Operation.post()
  Future<Response> transferTokens({@Bind.body(require: ['from', 'to', 'amount']) TransferTokenSerilizer? serilizer})async{
    final TransferTokensModule tokensModule = TransferTokensModule(
      fromAccountNo: serilizer!.from,
      toAccountNo: serilizer.to,
      amount: serilizer.amount,
    );

    final res = await tokensModule.process();

    if(res.statusCode == 0){
      return ProcessResponse(
        responseType: ResponseType.success,
        body: {'message': 'Tokens transfered!'}
      ).httpResponse;
    }else{
      return ProcessResponse(
        responseType: ResponseType.failed,
        body: serializedBody(res.body)
      ).httpResponse;
    }
    
  }
}
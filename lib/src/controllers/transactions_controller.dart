import 'package:phantom_model_manager/phantom_model_manager.dart';
import 'package:water_atm_demo/src/models/transaction_activity_model.dart';
import 'package:water_atm_demo/water_atm_demo.dart';

class TransactionsController extends ResourceController {
  final TransactionActivityModel transactionModel = TransactionActivityModel();
  // get transactions
  @Operation.get()
  Future<Response> fetchTransactions({
    @Bind.query('limit') int limit = 100, @Bind.query('search') String? search
  })async{
    SelectorBuilder _selector = where.limit(limit);
    if (search != null && search.isNotEmpty) { 
      _selector = where.limit(limit)
                    .match('accountNo',  search)
                    .or(where.match('transactionId',  search))
                    .or(where.match('amount',  search))
                    .or(where.match('paymentMethod',  search));
    }

    final res = await transactionModel.find(_selector);

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
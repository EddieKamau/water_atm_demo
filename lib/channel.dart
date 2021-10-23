import 'package:water_atm_demo/src/controllers/account_activities_controller.dart';
import 'package:water_atm_demo/src/controllers/account_controller.dart';
import 'package:water_atm_demo/src/controllers/debit_account_controller.dart';
import 'package:water_atm_demo/src/controllers/deposit_account_controller.dart';
import 'package:water_atm_demo/src/controllers/transactions_controller.dart';
import 'package:water_atm_demo/src/controllers/transfer_tokens_controller.dart';
import 'package:water_atm_demo/water_atm_demo.dart';


class WaterAtmDemoChannel extends ApplicationChannel {
  
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }


  @override
  Controller get entryPoint {
    final router = Router();

    // accounts
    router.route("/accounts/[:accountNo]")
    .link(() => AccountController());

    // account activities
    router.route("/accountActivities/[:accountNo]")
    .link(() => AccountActivitiesController());

    // debit account
    router.route("/debitAccount")
    .link(() => DebitAccountController());

    // debit account
    router.route("/deposit")
    .link(() => DepositAccountCotroller());

    // transfer tokens
    router.route("/transferTokens")
    .link(() => TransferTokenController());

    // transactions
    router.route("/transactions")
    .link(() => TransactionsController());

    return router;
  }

}

import 'package:phantom_model_manager/phantom_model_manager.dart';

export 'package:phantom_model_manager/phantom_model_manager.dart';

class Model extends ModelManager {
  Model(String collectionName) : super(dbUrl: 'mongodb://localhost:27017/water_atm_demo', collectionName: collectionName);

  
}
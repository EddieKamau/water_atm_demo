
import 'dart:convert';

import 'package:phantom_model_manager/phantom_model_manager.dart' show ObjectId;

dynamic objectIdEncode(dynamic item) {
    try {
      if(item is ObjectId) {
        return item.toJson();
      }else if(item is DateTime) {
        return item.toIso8601String();
      }
      
      return item;
    } catch (e) {
      print(e);
      return null;
    }
}

dynamic serializedBody(dynamic body){
  try {
    return json.decode(json.encode(body, toEncodable: objectIdEncode));
  } catch (e) {
    print(e);
    return null;
  }
}
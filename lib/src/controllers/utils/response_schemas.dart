import 'package:water_atm_demo/water_atm_demo.dart' show 
        APIResponse, APISchemaObject, APIMediaType, APIType;

Map<String, APIResponse> successfulResponseSchema({APISchemaObject? body}){
  return {
    "200": APIResponse(
    "Successful response.",
    content: {
      "body": APIMediaType(schema: APISchemaObject.object({
        "statusCode": APISchemaObject.integer(),
        if(body != null) "body": body,
      })),
    }
  ),
  };
}

Map<String, APIResponse> failedResponseSchema({
  bool missingRequirements = false,
  bool failed = false,
  bool warning = false,
  bool error = false,
}){
  return {
    '400': APIResponse(
    "Failed/warning response; User error",
    content: {
      if(missingRequirements) "Missing requirement(s)": APIMediaType(schema: APISchemaObject.object({
        "error": APISchemaObject.string(),
        "reasons": APISchemaObject.array(ofType: APIType.string)
      })),
      if(failed) "Failed": APIMediaType(schema: APISchemaObject.object({
        "statusCode": APISchemaObject.integer(),
        "body": APISchemaObject.object({})
      })),
      if(warning) "Waring": APIMediaType(schema: APISchemaObject.object({
        "statusCode": APISchemaObject.integer(),
        "warning": APISchemaObject.object({})
      })),
      "Error": APIMediaType(schema: APISchemaObject.object({
        "error": APISchemaObject.string(),
      })),
    }
  ),
  };
}

Map<String, APIResponse> unauthorizedSchema()=>{
  "401": APIResponse('Unauthorized')
};

Map<String, APIResponse> forbiddenSchema()=>{
  "403": APIResponse(
    'Forbidden', 
    content: {
      'Forbidden': APIMediaType(schema: APISchemaObject.object({
        "statusCode": APISchemaObject.integer(),
        "body": APISchemaObject.object({})
      })),
    }
  )
};

Map<String, APIResponse> notFoundSchema({bool resourceNotFound = false})=>{
  "404": APIResponse(
    'Resource or page not found', 
    content: {
      if(resourceNotFound) 'Resource not found': APIMediaType(schema: APISchemaObject.object({
        "statusCode": APISchemaObject.integer(),
        "body": APISchemaObject.object({})
      })),
      'Page not found': APIMediaType(schema: APISchemaObject.empty()),
    }
  )
};

Map<String, APIResponse> mehodNotAllowedSchema()=>{
  "405": APIResponse('Method Not Allowed',)
};

Map<String, APIResponse> serverErrorSchema()=>{
  "500": APIResponse(
    'Internal Server Error', 
    content: {
      'Identified error': APIMediaType(schema: APISchemaObject.object({
        "statusCode": APISchemaObject.integer(),
        "error": APISchemaObject.string()
      })),
      'Unknown error': APIMediaType(schema: APISchemaObject.empty()),
    }
  )
};
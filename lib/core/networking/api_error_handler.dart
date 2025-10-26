import 'package:dio/dio.dart';
import 'package:market_app/core/networking/api_constants.dart';
import 'package:market_app/core/networking/api_error_model.dart';


enum DataSource {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_FOUND = 404;
  static const int API_LOGIC_ERROR = 422;

  //local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT = ApiErrors.noContent;
  static const String BAD_REQUEST = ApiErrors.badRequestError;
  static const String UNAUTHORIZED = ApiErrors.unAuthorizedError;
  static const String FORBIDDEN = ApiErrors.forbiddenError;
  static const String INTERNAL_SERVER_ERROR = ApiErrors.internalServerError;
  static const String NOT_FOUND = ApiErrors.notFoundError;

  //local status code
  static const String CONNECT_TIMEOUT = ApiErrors.timeOutError;
  static const String CANCEL = ApiErrors.defaultError;
  static const String RECIEVE_TIMEOUT = ApiErrors.timeOutError;
  static const String SEND_TIMEOUT = ApiErrors.timeOutError;
  static const String CACHE_ERROR = ApiErrors.cacheError;
  static const String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static const String DEFAULT = ApiErrors.defaultError;
}
extension DataSourceExtension on DataSource{
ApiErrorModel getFailure(){
  switch (this) {
    case DataSource.NO_CONTENT:
      return ApiErrorModel(
        message:ResponseMessage.NO_CONTENT,
        code: ResponseCode.NO_CONTENT
         );
    case DataSource.BAD_REQUEST:
      return ApiErrorModel(
        message:ResponseMessage.BAD_REQUEST,
        code: ResponseCode.BAD_REQUEST
         );
    case DataSource.FORBIDDEN:
      return ApiErrorModel(
        message: ResponseMessage.FORBIDDEN,
        code: ResponseCode.FORBIDDEN
        );     
    case DataSource.UNAUTHORIZED:
      return ApiErrorModel(
        message:ResponseMessage.UNAUTHORIZED,
        code: ResponseCode.UNAUTHORIZED,
         ); 
    case DataSource.NOT_FOUND:
      return ApiErrorModel(
        message:ResponseMessage.NOT_FOUND,
        code: ResponseCode.NOT_FOUND
        );      
    case DataSource.INTERNAL_SERVER_ERROR:
      return ApiErrorModel(
        message:ResponseMessage.INTERNAL_SERVER_ERROR,
        code: ResponseCode.INTERNAL_SERVER_ERROR
         );   
    case DataSource.CONNECT_TIMEOUT:
      return ApiErrorModel(
        message:ResponseMessage.CONNECT_TIMEOUT,
        code: ResponseCode.CONNECT_TIMEOUT
         );            
    case DataSource.CANCEL:
      return ApiErrorModel(
        message:ResponseMessage.CANCEL,
        code: ResponseCode.CANCEL
         );     
    case DataSource.RECIEVE_TIMEOUT:
      return ApiErrorModel(
        message:ResponseMessage.RECIEVE_TIMEOUT,
        code: ResponseCode.RECIEVE_TIMEOUT
         );     
    case DataSource.SEND_TIMEOUT:
      return ApiErrorModel(
        message:ResponseMessage.SEND_TIMEOUT,
        code: ResponseCode.SEND_TIMEOUT
         );     
    case DataSource.CACHE_ERROR:
      return ApiErrorModel(
        message:ResponseMessage.CACHE_ERROR,
        code: ResponseCode.CACHE_ERROR
         );     
    case DataSource.NO_INTERNET_CONNECTION:
      return ApiErrorModel(
        message: ResponseMessage.NO_INTERNET_CONNECTION,
        code:ResponseCode.NO_INTERNET_CONNECTION
        );     
    case DataSource.DEFAULT:
      return ApiErrorModel(
        message:ResponseMessage.DEFAULT,
        code: ResponseCode.DEFAULT
         );
  }
}
}

class ErrorHandler implements Exception{
  late ApiErrorModel apiErrorModel;
  ErrorHandler.handle(dynamic error){
    if(error is DioException){
      apiErrorModel=_handleError(error);
    }else{
      apiErrorModel=DataSource.DEFAULT.getFailure();
    }
  }
}
ApiErrorModel _handleError(DioException error){
 switch(error.type){
   case DioExceptionType.connectionTimeout:
    return DataSource.CONNECT_TIMEOUT.getFailure();
   case DioExceptionType.sendTimeout:
    return DataSource.SEND_TIMEOUT.getFailure();
   case DioExceptionType.receiveTimeout:
    return DataSource.RECIEVE_TIMEOUT.getFailure();
   case DioExceptionType.unknown:
     if(error.response!=null&&error.response?.statusCode!=null&&error.response?.statusMessage!=null){
      return ApiErrorModel.fromJson(error.response!.data);
     }else{
      return DataSource.DEFAULT.getFailure();
     } 
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
    return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
     return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badResponse:
     return DataSource.DEFAULT.getFailure();  
 }
}
class ApiInternalStatus{
  static const int SUCCESS=0;
  static const int FAILURE=1;
}
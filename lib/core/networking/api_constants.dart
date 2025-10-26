class ApiConstants {
  static const String apiBaseUrl = 'https://fakestoreapi.com/';
  static const String login = 'auth/login';
  static const String signup = 'users';
  static const String getAllProducts = 'products';
  static const String getProductById = 'products';
}
class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unAuthorizedError = "unAuthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unKnownError = "unKnownError";
  static const String timeOutError = "timeOutError";
  static const String defaultError = "Something went wrong";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loadingMessage";
  static const String retryAgainMessage = "retryAgainMessage";
  static const String ok = "ok";
}

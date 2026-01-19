class SpotstockStatusCode {
  static const int unknown = 0;
  static const int internalAppError = 1;
  static const int internalAppDatabaseError = 2;
  static const int outOfStock = 3;
  static const int invalidPin = 4;
  static const int invalidHoldId = 5;
  static const int invalidHoldReferenceCode = 6;
  static const int invalidCustomerPhone = 7;
  static const int invalidCustomerId = 8;
  static const int success = 200;
  static const int created = 201;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int forbidden = 403;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;
}

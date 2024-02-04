class ApiPath {
  static String products() => 'products/';
  static String product(String documentId) => 'products/$documentId';
  static String user(String id) => 'users/$id';
  static String addToCart(String uid, String cartId) => 'users/$uid/cart/$cartId';
  static String getCartItems(String uid) => 'users/$uid/cart/';
  static String locations(String uid) => 'users/$uid/locations/';
  static String location(String uid, String locationId) => 'users/$uid/locations/$locationId';
  static String payments(String uid) => 'users/$uid/payments/';
}

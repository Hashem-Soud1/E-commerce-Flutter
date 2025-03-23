class ApiPaths {
  static String users(String userId) => 'users/$userId'; // users/$userId
  static String cart(String userId, String cartId) =>
      'users/$userId/cart/$cartId';
  static String products() => 'products/'; // products/
  static String product(String productId) =>
      'products/$productId'; // products/$productId

  static String homeCarouselItems() => 'announcements/'; // home_carousel_items/
  static String categories() => 'categories/'; // categories/
}

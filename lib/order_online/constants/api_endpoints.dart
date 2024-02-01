class ApiEndpoints {
  static const baseUrl = 'https://foodpage.co.uk/development/v1/mobile/shop';
  static const baseUrlTwo = 'https://foodpage.co.uk/development/v2/shop';
  static const socketBaseUrl = "https://foodpagenodeserver.vgrex.com/";
  static const loginUser = '/admin/login';
  static const onlineOrderList = '/order?categories%5B%5D=';
  static const diningOrderList = '/order-dining?categories=';
  static const orderDetails = '/order/';
  static const listAllDishes = '/products';
  static const timeDetails = '/timing';
  static const saveTime = '/timing/save';
  static const shopSettings = '/settings';
  static const saveShopSettings = '/settings/save';
  static const shopProfileDetails = '/profile';
  static const saveShopProfile = '/profile';
  static const dailyReports = '/reports/daily/';
  static const shopStatus = '/settings/status/';
  static const acceptOrder = '/manageorder/accept/';
  static const rejectOrder = '/manageorder/reject/';
  static const dispatchOrder = '/manageorder/dispatch/';
  static const categoryList = '/categories/';
}

class ApiUrls {
  // Base Url
  static String baseUrl = "https://tradepro-1.onrender.com";

  // Register
  static String registerUrl = "$baseUrl/api/auth/register";

  // Verify OTP
  static String verifyOtp = "$baseUrl/api/auth/verifyOtp";
  // ChangePassword
  static String changePasswordSettings = "$baseUrl/api/settings/changePassword";

  // Login
  static String loginUrl = "$baseUrl/api/auth/login";

  // Course listing
  static String courseListing = "$baseUrl/api/course/findCourse";

  // Course detail listing
  static String courseDetailListing = "$baseUrl/api/course/findOneCourse";

  // Checkout api
  static String courseCheckout = "$baseUrl/api/course/checkOut";

  // make it unloack
  static String chapterUnloack = "$baseUrl/api/course/chapterIsPlayed";

  // find user profile
  static String findUserProfile = "$baseUrl/api/settings/findProfile";

  // update user profile
  static String porfileUpdate = "$baseUrl/api/settings/updateProfile";

  // wishlist read
  static String listWishList = "$baseUrl/api/settings/findWishlist";

  // creat wishlist
  static String addToWishlist = "$baseUrl/api/settings/createWishlist";

  // Delete whishlist
  static String removeFromWishlist = "$baseUrl/api/settings/updateProfile";
}

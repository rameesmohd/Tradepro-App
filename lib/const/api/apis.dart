class ApiUrls {
  // Base Url
  static String baseUrl = "https://tradepro-1.onrender.com";

  // Register
  static String registerUrl = "$baseUrl/api/auth/register";

  // Verify OTP
  static String verifyOtp = "$baseUrl/api/auth/verifyOtp";

  // Login
  static String loginUrl = "$baseUrl/api/auth/login";

  // Course listing
  static String courseListing = "$baseUrl/api/course/findCourse";

  // Course detail listing
  static String courseDetailListing = "$baseUrl/api/course/findOneCourse";
}

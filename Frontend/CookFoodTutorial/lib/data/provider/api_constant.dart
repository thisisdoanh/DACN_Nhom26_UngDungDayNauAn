class ApiConstant {
  ApiConstant._();

  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);

  static const String baseUrl =
      "https://1d92df4b-4a60-447b-a5f4-e7d285b780a5.mock.pstmn.io";

  // End point
  static const String epAuthToken = "/auth/token";
  static const String epRegister = "/api/v1/users";
  static const String epUserInfo = "/api/v1/users/myInfo";
  static const String epFindAllRecipe = "/api/v1/recipes/find-all";
  static const String epFindRecipe = "/api/v1/recipes";
  static const String epRecipeFavorite = "/api/v1/favorite-recipe/";
  static const String epCategories = "/api/v1/categories";
  static const String epComment = "/api/v1/review";
  static const String epForgotPass = '/forgot-password/verify-mail/';
  static const String epInputOtp = '/forgot-password/verify-otp/';
  static const String epVerifyAcc = '/forgot-password/change-password/';
}

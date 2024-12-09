class ApiConstant {
  ApiConstant._();

  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);

  static const String baseUrl = "https://1d92df4b-4a60-447b-a5f4-e7d285b780a5.mock.pstmn.io";

  // End point
  static const String epAuthToken = "/auth/token";
}

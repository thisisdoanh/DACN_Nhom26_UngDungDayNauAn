import 'dart:convert';

import '../../common/utils/app_utils.dart';
import '../model/base_response.dart';
import '../model/user_token_model.dart';
import 'api_client.dart';
import 'api_constant.dart';

class ApiService {
  ApiService._();

  static Future<UserToken?> getVerifyAccount({required String mail, required String password}) async {
    BaseResponse response = await ApiClient.instance.request(
        endPoint: ApiConstant.epAuthToken,
        method: ApiClient.post,
        data: jsonEncode({
          "email": "chien.haui0807@gmail.com",
          "password": "123456789",
        }));

    if (response.result == true) {
      UserToken userToken = UserToken.fromMap(response.data);

      return userToken;
    } else {
      showToast((response.message ?? '').isEmpty ? 'Unknown error' : (response.message ?? ''));

      return Future.value(null);
    }
  }
}

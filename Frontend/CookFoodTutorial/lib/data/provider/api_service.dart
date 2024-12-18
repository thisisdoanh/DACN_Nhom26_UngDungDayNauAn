import 'dart:convert';

import 'package:tutorial/data/model/category_response_model.dart';
import 'package:tutorial/data/model/comment_request.dart';
import 'package:tutorial/data/model/comment_response.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/data/model/user_info_response.dart';

import '../../common/utils/app_utils.dart';
import '../model/base_response.dart';
import '../model/user_token_model.dart';
import 'api_client.dart';
import 'api_constant.dart';

class ApiService {
  ApiService._();

  static Future<UserToken?> getVerifyAccount(
      {required String mail, required String password}) async {
    BaseResponse response = await ApiClient.instance.request(
        endPoint: ApiConstant.epAuthToken,
        method: ApiClient.post,
        data: jsonEncode({
          "email": mail,
          "password": password,
        }));

    if (response.result == true) {
      UserToken userToken = UserToken.fromMap(response.data);

      return userToken;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return Future.value(null);
    }
  }

  static Future<UserInfo?> createAccount(
      {required String mail,
      required String password,
      required String name}) async {
    Map<String, String> mapName = splitName(name);
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epRegister,
      method: ApiClient.post,
      data: jsonEncode(
        {
          "email": mail,
          "password": password,
          "firstName": mapName['firstName'],
          "lastName": mapName['lastName'],
          "dob": "01/01/1970",
          "roles": ["USER"],
        },
      ),
    );

    if (response.result == true) {
      UserInfo userInfo = UserInfo.fromMap(response.data);

      return userInfo;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return Future.value(null);
    }
  }

  static Future<UserInfo?> getUserInfo() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epUserInfo,
      method: ApiClient.get,
    );

    if (response.result == true) {
      UserInfoResponse userInfoResponse =
          UserInfoResponse.fromMap(response.data);

      return userInfoResponse.data;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return Future.value(null);
    }
  }

  static Future<List<CategoryModel>> getCategories() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epCategories,
      method: ApiClient.get,
    );

    if (response.result == true) {
      CategoryResponse categoryResponse =
          CategoryResponse.fromMap(response.data);

      return categoryResponse.data ?? [];
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return Future.value([]);
    }
  }

  static Future<List<RecipeModel>> getRecipes() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epFindAllRecipe,
      method: ApiClient.get,
    );

    if (response.result == true) {
      RecipeResponse recipeResponse = RecipeResponse.fromMap(response.data);

      return recipeResponse.data?.items ?? [];
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return Future.value([]);
    }
  }

  static Future<List<RecipeModel>> getRecipeFavorite(int? userID) async {
    if (userID == null) {
      return Future.value([]);
    }
    BaseResponse response = await ApiClient.instance.request(
      endPoint: "${ApiConstant.epRecipeFavorite}$userID",
      method: ApiClient.get,
    );

    if (response.result == true) {
      RecipeResponse recipeResponse = RecipeResponse.fromMap(response.data);

      return recipeResponse.data?.items ?? [];
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return Future.value([]);
    }
  }

  static Future<bool> forgotPass(String email) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epForgotPass + email,
      method: ApiClient.post,
    );

    if (response.result == true) {
      return true;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return false;
    }
  }

  static Future<bool> inputOtp(String email, String otp) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: "${ApiConstant.epInputOtp}$email/$otp",
      method: ApiClient.post,
    );

    if (response.result == true) {
      return true;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return false;
    }
  }

  static Future<bool> verifyAcc(String email, String pass) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epForgotPass + email,
      method: ApiClient.post,
      formData: {
        "password": pass,
        "repeatPassword": pass,
      },
    );

    if (response.result == true) {
      return true;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return false;
    }
  }

  static Future<bool> createComment(CommentRequest cmt) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epComment,
      data: jsonEncode(cmt.toJson()),
      method: ApiClient.post,
    );

    return response.result ?? false;
  }

  static Future<bool> updateComment(CommentRequest cmt) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.epComment,
      method: ApiClient.put,
      data: jsonEncode(cmt.toJson()),
    );

    return response.result ?? false;
  }

  static Future<bool> deleteComment(
      {required int? userId,
      required int? recipeId,
      required String commentIndex}) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: '${ApiConstant.epComment}/$userId/$recipeId/$commentIndex',
      method: ApiClient.delete,
    );

    if (response.result == true) {
      return true;
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));
      return false;
    }
  }

  static Future<List<CommentModel>> getComment(int? recipeId) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: '${ApiConstant.epComment}/$recipeId',
      method: ApiClient.get,
    );

    if (response.result == true) {
      CommentResponse res = CommentResponse.fromJson(response.data);
      return res.data ?? [];
    } else {
      showToast((response.message ?? '').isEmpty
          ? 'Unknown error'
          : (response.message ?? ''));

      return [];
    }
  }
}

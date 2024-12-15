import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_utils.dart';
import 'package:tutorial/data/model/comment_request.dart';
import 'package:tutorial/data/model/comment_response.dart' as cmt;
import 'package:tutorial/data/model/comment_response.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/data/provider/api_service.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/view/widget/app_bottom_sheet.dart';

class FoodDetailController extends AppBaseController {
  final RxInt curentStart = 5.obs;
  RecipeModel recipeModel = RecipeModel();
  RxList<CommentModel> commentList = RxList();
  TextEditingController commentCtrl = TextEditingController();

  @override
  void onInit() async {
    if (Get.arguments is RecipeModel) {
      recipeModel = Get.arguments;
    }
    showLoading();
    await getComment();
    await 0.5.seconds.delay();
    hideLoading();
    super.onInit();
  }

  void goToGuideScreen(Widget guideScreen) {
    Get.bottomSheet(
      SDSBottomSheet(
        title: recipeModel.recipeName ?? '',
        body: guideScreen,
        miniSizeHeight: Get.height * 0.8,
      ),
      isScrollControlled: true,
    );
  }

  void goToRatingScreen(Widget ratingScreen) {
    Get.dialog<CommentRequest>(ratingScreen).then(
      (value) {
        if (value != null) {
          final rating = int.tryParse(value.rating ?? '5') ?? 5;
          if (value.isUpdate) {
            final index = commentList.indexWhere(
                (element) => element.commentIndex == value.commentIndex);
            if (index != -1) {
              commentList[index]
                ..comment = value.comment
                ..rating = rating;
            }
          } else {
            final newComment = CommentModel(
              comment: value.comment,
              rating: rating,
              recipeId: int.tryParse(value.recipeId ?? '5') ?? 5,
              user: cmt.User(
                id: int.tryParse(value.userId ?? '5') ?? 5,
                email: appController.userInfo.email,
                firstName: appController.userInfo.firstName,
                lastName: appController.userInfo.lastName,
              ),
            );
            commentList.add(newComment);
          }
          commentList.refresh();
        }
      },
    );
  }

  void rating(int index) {
    curentStart.value = index;
  }

  Future createComment() async {
    final CommentRequest cmt = CommentRequest(
      comment: commentCtrl.text,
      rating: curentStart.value.toString(),
      recipeId: recipeModel.id.toString(),
      userId: appController.userInfo.id.toString(),
    );
    showLoading();
    final response = await ApiService.createComment(cmt);
    hideLoading();
    if (response) {
      showToast('Đánh giá thành công');
      Get.back(result: cmt);
    } else {
      showToast('Đánh giá thất bại, có lỗi hệ thống!');
      Get.back();
    }
  }

  Future updateComment(String cmtIndex) async {
    final CommentRequest cmt = CommentRequest(
      comment: commentCtrl.text,
      rating: curentStart.value.toString(),
      recipeId: recipeModel.id.toString(),
      userId: appController.userInfo.id.toString(),
    );
    showLoading();
    final response = await ApiService.updateComment(cmt);
    hideLoading();
    if (response) {
      showToast('Cập nhật đánh giá thành công');
      Get.back(
        result: cmt
          ..commentIndex = cmtIndex
          ..isUpdate = true,
      );
    } else {
      showToast('Cập nhật đánh giá thất bại, thử lại sau!');
      Get.back();
    }
  }

  Future deleteComment(CommentModel cmt) async {
    showLoading();
    final response = await ApiService.deleteComment(
      userId: appController.userInfo.id,
      recipeId: recipeModel.id,
      commentIndex: cmt.commentIndex ?? '',
    );
    hideLoading();
    if (response) {
      commentList.remove(cmt);
      showToast('Xóa đánh giá thành công!');
    } else {
      showToast(' Xóa đánh giá thất bại, hãy thử lại sau!');
    }
  }

  Future getComment() async {
    final response = await ApiService.getComment(recipeModel.id);
    commentList.assignAll(response);
  }
}

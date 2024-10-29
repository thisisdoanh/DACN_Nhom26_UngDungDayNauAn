import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tutorial/res/string/app_string.dart';

import '../../presentation/view/resources/app_color.dart';

String capitalizeOnlyFirstLater(String originalText) {
  if (originalText.trim().isEmpty) return "";
  return "${originalText[0].toUpperCase()}${originalText.substring(1)}";
}

showToast(String text, {bool isLong = true}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: AppColors.black.withOpacity(0.9),
    textColor: AppColors.white,
    fontSize: 16,
  );
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

bool isNullEmpty(Object? o) => o == null || "" == o || o == "null";

bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

bool isNullEmptyFalseOrZero(Object? o) =>
    o == null || false == o || 0 == o || "" == o || "0" == o;

bool isNullEmptyList<T>(List<T>? t) => t == null || [] == t || t.isEmpty;

bool isNullEmptyMap<T>(Map<T, T>? t) => t == null || {} == t || t.isEmpty;

bool isNumeric(dynamic s) {
  String sConvert = s.toString();
  if (isNullEmpty(sConvert)) {
    return false;
  }
  return (double.tryParse(sConvert) != null || int.tryParse(sConvert) != null);
}

bool checkValidEmail(String email) {
  String textEmail = email.trim();
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern as String);
  return regex.hasMatch(textEmail);
}

String validateEmailAndReturnValue(String email) {
  if (email.isEmpty || email == "") {
    return StringConstants.valueRequire.tr.trParams({
      "value": StringConstants.email.tr,
    });
  }

  if (!checkValidEmail(email)) {
    return StringConstants.emailNotCorrectFormat.tr;
  }

  return "";
}

String validateValueNotEmpty(String value, String valueReplace) {
  if (value.isEmpty || value == "") {
    return StringConstants.valueRequire.tr.trParams({
      "value": valueReplace,
    });
  }
  return "";
}

String validatePasswordAndRePassword(String password, String rePassword) {
  if (password != rePassword) {
    return StringConstants.rePasswordNotCorrect.tr;
  }
  return "";
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_base_controller.dart';

abstract class AppBaseWidget<T extends AppBaseController> extends GetWidget<T> {
  const AppBaseWidget({super.key});

  Widget buildWidget();

  @override
  Widget build(BuildContext context) {
    return buildWidget();
  }
}

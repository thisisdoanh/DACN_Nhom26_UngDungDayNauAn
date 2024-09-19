import 'package:flutter/material.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/login/login_controller.dart';

class LoginScreen extends AppBaseScreen<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildWidget() {
    return AppContainer();
  }
}

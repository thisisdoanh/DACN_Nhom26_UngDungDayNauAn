// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';

class BackGroundShare extends StatelessWidget {
  const BackGroundShare({
    super.key,
    this.body,
  });
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.primaryText,
                AppColor.dsGray3,
              ],
            ),
          ),
          child: body,
        ),
      ),
    );
  }
}

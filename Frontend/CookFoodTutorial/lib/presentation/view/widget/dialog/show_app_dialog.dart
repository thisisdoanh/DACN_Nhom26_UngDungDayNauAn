import 'package:flutter/material.dart';

import 'app_dialog.dart';

Future showAppDialog(
  BuildContext context,
  String titleText,
  String messageText, {
  Widget? messageWidget,
  Widget? widgetBody,
  Widget? widgetTopRight,
  Widget? coverScreenWidget,
  String? firstButtonText,
  VoidCallback? firstButtonCallback,
  String? secondButtonText,
  VoidCallback? secondButtonCallback,
  bool dismissAble = true,
  WidgetBuilder? builder,
  Color? backgroundColor,
  double? heightDialog,
  double? widthDialog,
  bool? hideGroupButton,
  Widget? fullContentWidget,
  EdgeInsetsGeometry? padding,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissAble,
    builder: builder ??
        (BuildContext context) => AppDialog(
              title: titleText,
              message: messageText,
              messageWidget: messageWidget,
              widgetBody: widgetBody,
              widgetTopRight: widgetTopRight,
              coverScreenWidget: coverScreenWidget,
              firstButtonCallback: firstButtonCallback,
              secondButtonText: secondButtonText,
              secondButtonCallback: secondButtonCallback,
              backgroundColor: backgroundColor,
              heightDialog: heightDialog,
              widthDialog: widthDialog,
              hideGroupButton: hideGroupButton,
              fullContentWidget: fullContentWidget,
              firstButtonText: firstButtonText ?? "Cancel",
              padding: padding,
            ),
  );
}

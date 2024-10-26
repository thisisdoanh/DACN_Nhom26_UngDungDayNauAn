import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_view.dart';

class AppTextField extends StatelessWidget {
  final int? maxLength;
  final int? maxLines;
  final String? hintText;
  final String? errorText;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onPressed;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? outlineColor;
  final Widget? prefixIcon;
  final bool? isHide;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;

  const AppTextField({
    super.key,
    this.maxLength,
    this.maxLines,
    this.hintText,
    this.errorText,
    this.textEditingController,
    this.onChanged,
    this.keyboardType,
    this.readOnly,
    this.onPressed,
    this.contentPadding,
    this.suffixIcon,
    this.backgroundColor,
    this.outlineColor,
    this.prefixIcon,
    this.isHide,
    this.border,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.white,
            borderRadius: borderRadius,
            border: border ??
                Border(
                  bottom: BorderSide(
                    color: AppColors.white,
                    width: 1.sp,
                  ),
                ),
          ),
          child: TextField(
            readOnly: readOnly ?? false,
            onTap: onPressed,
            controller: textEditingController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength ?? 250),
            ],
            maxLines: maxLines,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: AppTextTheme.labelLarge(AppColors.white),
            cursorColor: AppColors.white,
            obscureText: isHide ?? false,
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                    vertical: 8.sp,
                    horizontal: 16.0.sp,
                  ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: outlineColor ?? Colors.transparent),
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: outlineColor ?? Colors.transparent),
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
              hintText: hintText,
              hintStyle: AppTextTheme.labelLarge(AppColors.dsGray4),
              suffixIcon: suffixIcon,
              isDense: true,
              focusColor: AppColors.white,
              prefixIcon: prefixIcon,
            ),
          ),
        ),
        (errorText ?? '').isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.only(
                  top: 4.0.sp,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    errorText ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
      ],
    );
  }
}

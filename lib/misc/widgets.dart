import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';

export 'package:flutter_spinkit/flutter_spinkit.dart';

class Holder {
  final String content;
  bool selected;

  Holder({
    required this.content,
    this.selected = false,
  });
}

class SpecialForm extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool obscure;
  final bool autoValidate;
  final FocusNode? focus;
  final bool autoFocus;
  final Function? onChange;
  final Function? onActionPressed;
  final Function? onValidate;
  final Function? onSave;
  final BorderRadius? radius;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool readOnly;
  final int maxLines;
  final double width;
  final double height;

  const SpecialForm({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
    this.fillColor,
    this.borderColor,
    this.padding,
    this.hintStyle,
    this.focus,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscure = false,
    this.autoValidate = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.none,
    this.onActionPressed,
    this.onChange,
    this.onValidate,
    this.style,
    this.onSave,
    this.radius,
    this.hint,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        style: style ?? context.textTheme.bodyMedium,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        maxLines: maxLines,
        focusNode: focus,
        autofocus: autoFocus,
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        textInputAction: action,
        readOnly: readOnly,
        onEditingComplete: () => onActionPressed!(controller.text),
        cursorColor: appBlue,
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          fillColor: fillColor ?? Colors.transparent,
          filled: true,
          contentPadding:
              padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          prefixIcon: prefix,
          suffixIcon: suffix,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? fadedBorder,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? fadedBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? fadedBorder,
            ),
          ),
          hintText: hint,
          hintStyle: hintStyle ??
              context.textTheme.labelMedium!
                  .copyWith(fontWeight: FontWeight.w200),
        ),
        onChanged: (value) {
          if (onChange == null) return;
          onChange!(value);
        },
        validator: (value) {
          if (onValidate == null) return null;
          return onValidate!(value);
        },
        onSaved: (value) {
          if (onSave == null) return;
          onSave!(value);
        },
      ),
    );
  }
}

class Copyright extends StatelessWidget {
  const Copyright({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.copyright, color: Colors.grey, size: 16.r),
        SizedBox(width: 3.w),
        Text(
          "${DateTime.now().year}. Oostel. All rights reserved",
          style: context.textTheme.bodySmall!
              .copyWith(color: Colors.grey, fontSize: 12.sp),
        ),
      ],
    );
  }
}

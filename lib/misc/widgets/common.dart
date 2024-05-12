import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_hostel/misc/constants.dart';


class Holder<T> {
  T content;

  Holder({
    required this.content,
  });
}

const Widget loader = SpinKitSpinningLines(
  color: Colors.white,
  size: 50,
);

const Widget blueLoader = SpinKitSpinningLines(
  color: appBlue,
  size: 50,
);

enum AcquireType { hostel, roommate }

class TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  TabHeaderDelegate({required this.tabBar, this.color});

  final TabBar tabBar;
  final Color? color;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: color ?? Colors.white,
        child: tabBar,
      );

  @override
  bool shouldRebuild(TabHeaderDelegate oldDelegate) => false;
}

class WidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  WidgetHeaderDelegate(
      {required this.widget, this.height = 1.0, this.color = Colors.white});

  final Widget widget;
  final double height;
  final Color color;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        height: height,
        color: color,
        child: widget,
      );

  @override
  bool shouldRebuild(WidgetHeaderDelegate oldDelegate) => false;
}

class CustomGrouper extends TextInputFormatter {
  final int? by;
  final int then;

  const CustomGrouper({
    this.by,
    required this.then,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (by != null && text.length == by!) {
      return newValue;
    }

    String rest = "", firstGroup = "";

    if (by != null) {
      firstGroup = text.substring(0, by);
      rest = text.substring(by!);
    }

    String source = r'.{$then}';
    rest =
        rest.replaceAllMapped(RegExp(r'.{4}'), (match) => "${match.group(0)} ");
    text = "$firstGroup $rest";
    if (by == null) {
      text = text.substring(1);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class SpecialForm extends StatelessWidget {
  @override
  final Key? key;
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
  final List<TextInputFormatter> formatters;
  final BoxDecoration? decoration;

  const SpecialForm({
    this.key,
    required this.controller,
    required this.width,
    required this.height,
    this.formatters = const [],
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
    this.decoration,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration ?? const BoxDecoration(),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          style: style ??
              context.textTheme.bodyMedium!
                  .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          inputFormatters: formatters,
          maxLines: maxLines,
          focusNode: focus,
          autofocus: autoFocus,
          controller: controller,
          obscureText: obscure,
          keyboardType: type,
          textInputAction: action,
          readOnly: readOnly,
          onEditingComplete: () {
            if (onActionPressed != null) {
              onActionPressed!(controller.text);
            }
          },
          cursorColor: appBlue,
          decoration: InputDecoration(
            errorMaxLines: 1,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            contentPadding: padding ??
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            prefixIcon: prefix,
            suffixIcon: suffix,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? fadedBorder,
              ),
              borderRadius: radius ?? BorderRadius.circular(0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? fadedBorder,
              ),
              borderRadius: radius ?? BorderRadius.circular(0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? fadedBorder,
              ),
              borderRadius: radius ?? BorderRadius.circular(0),
            ),
            hintText: hint,
            hintStyle: hintStyle ??
                context.textTheme.bodyMedium!
                    .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}

class ComboBox extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final bool noDecoration;

  const ComboBox({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.noDecoration = false,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.textTheme.bodyMedium!
                .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
          ),
        ),
        value: value,
        items: dropdownItems
            .map(
              (String item) => DropdownMenuItem<String>(
            value: item,
            child: Container(
              alignment: valueAlignment,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: (noDecoration) ? null : buttonHeight ?? 40,
          width: (noDecoration) ? 80 : buttonWidth ?? 140,
          padding: (noDecoration)
              ? null
              : buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: (noDecoration)
              ? null
              : buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: fadedBorder),
              ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: iconSize ?? 12,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 200,
          width: dropdownWidth ?? 140,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all<double>(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 40,
          padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.copyright, color: Colors.grey, size: 16.r),
        SizedBox(width: 3.w),
        Text(
          "${DateTime.now().year}. Fynda. All rights reserved",
          style: context.textTheme.bodyMedium!.copyWith(color: weirdBlack50),
        ),
      ],
    );
  }
}

Widget flightShuttleBuilder(
    BuildContext context,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromContext,
    BuildContext toContext) {
  switch (direction) {
    case HeroFlightDirection.push:
      return ScaleTransition(
        scale: animation.drive(
          Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(
            CurveTween(curve: Curves.fastOutSlowIn),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: toContext.widget,
        ),
      );
    case HeroFlightDirection.pop:
      return fromContext.widget;
  }
}


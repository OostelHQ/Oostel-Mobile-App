import 'dart:io';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_hostel/components/comment.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/receipt_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

export 'package:flutter_spinkit/flutter_spinkit.dart';

class Holder<T> {
  T content;

  Holder({
    required this.content,
  });
}

const Widget loader = SpinKitThreeBounce(
  color: appBlue,
  size: 30,
);

enum AcquireType { hostel, roommate }

class TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  TabHeaderDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Colors.white,
        child: tabBar,
      );

  @override
  bool shouldRebuild(TabHeaderDelegate oldDelegate) => false;
}

class WidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  WidgetHeaderDelegate({required this.widget, this.height = 1.0});

  final Widget widget;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        height: height,
        color: Colors.white,
        child: widget,
      );

  @override
  bool shouldRebuild(WidgetHeaderDelegate oldDelegate) => false;
}

class SpecialForm extends StatefulWidget {
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
  State<SpecialForm> createState() => _SpecialFormState();
}

class _SpecialFormState extends State<SpecialForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        style: widget.style ??
            context.textTheme.bodyMedium!
                .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
        autovalidateMode: widget.autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        maxLines: widget.maxLines,
        focusNode: widget.focus,
        autofocus: widget.autoFocus,
        controller: widget.controller,
        obscureText: widget.obscure,
        keyboardType: widget.type,
        textInputAction: widget.action,
        readOnly: widget.readOnly,
        onEditingComplete: () =>
            widget.onActionPressed!(widget.controller.text),
        cursorColor: appBlue,
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          fillColor: widget.fillColor ?? Colors.transparent,
          filled: true,
          contentPadding: widget.padding ??
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? fadedBorder,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? fadedBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? fadedBorder,
            ),
          ),
          hintText: widget.hint,
          hintStyle: widget.hintStyle ??
              context.textTheme.bodyMedium!
                  .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
        ),
        onChanged: (value) {
          if (widget.onChange == null) return;
          widget.onChange!(value);
        },
        validator: (value) {
          if (widget.onValidate == null) return null;
          return widget.onValidate!(value);
        },
        onSaved: (value) {
          if (widget.onSave == null) return;
          widget.onSave!(value);
        },
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
                    borderRadius: BorderRadius.circular(10.r),
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
                borderRadius: BorderRadius.circular(14),
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
          style: context.textTheme.bodyMedium!.copyWith(color: weirdBlack50),
        ),
      ],
    );
  }
}

class ProfileNotification extends ConsumerStatefulWidget {
  const ProfileNotification({super.key});

  @override
  ConsumerState<ProfileNotification> createState() =>
      _ProfileNotificationState();
}

class _ProfileNotificationState extends ConsumerState<ProfileNotification> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HostelInfoCard extends StatefulWidget {
  final HostelInfo info;

  const HostelInfoCard({
    super.key,
    required this.info,
  });

  @override
  State<HostelInfoCard> createState() => _HostelInfoCardState();
}

class _HostelInfoCardState extends State<HostelInfoCard> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.hostelInfo,
        extra: widget.info,
      ),
      child: Card(
        elevation: 1.0,
        child: SizedBox(
          height: 120.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Hero(
                    tag:
                        "Hostel ID: ${widget.info.id} Image: ${widget.info.image}",
                    child: Image.asset(
                      widget.info.image,
                      height: 100.h,
                      width: 125.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Hero(
                            tag:
                                "Hostel ID: ${widget.info.id} Name: ${widget.info.name}",
                            child: Text(
                              widget.info.name,
                              style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                          ),
                          Hero(
                            tag: "Hostel ID: ${widget.info.id} Liked",
                            child: GestureDetector(
                              onTap: () => setState(() => liked = !liked),
                              child: AnimatedSwitcherTranslation.right(
                                duration: const Duration(milliseconds: 500),
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: liked ? Colors.red : weirdBlack20,
                                  size: 18,
                                  key: ValueKey<bool>(liked),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 17.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Hostel Info Bed.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.bedrooms}",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset("assets/images/Hostel Info Bath.svg",
                            width: 15.r, height: 15.r, color: weirdBlack50),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.bathrooms}",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset("assets/images/Hostel Info Area.svg",
                            width: 15.r, height: 15.r, color: weirdBlack25),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.area.toStringAsFixed(0)} sqft",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 17.5.h),
                    SizedBox(
                      width: 200.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${currency()} ${formatAmountInDouble(widget.info.price)}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "/year",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: appBlue,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Inter",
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 85.w,
                            height: 25.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: infoRoomsLeftBackground,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Text(
                              "${widget.info.roomsLeft.length} room${widget.info.roomsLeft.length == 1 ? "" : "s"} left",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: infoRoomsLeft,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentCard extends StatefulWidget {
  final Student info;

  const StudentCard({
    super.key,
    required this.info,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.otherStudent,
        extra: widget.info,
      ),
      child: Card(
        elevation: 1.0,
        child: SizedBox(
          height: 120.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.info.image),
                  radius: 48.r,
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.info.mergedNames,
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600, color: weirdBlack),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => liked = !liked),
                            child: AnimatedSwitcherTranslation.right(
                              duration: const Duration(milliseconds: 500),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: liked ? Colors.red : weirdBlack25,
                                size: 18,
                                key: ValueKey<bool>(liked),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 17.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Roomate Info Person.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.info.gender,
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(
                          "assets/images/Roomate Info Level.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.level} level",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(
                          "assets/images/Roomate Info Location.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.info.location,
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 17.5.h),
                    SizedBox(
                      width: 220.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${currency()} ${formatAmountInDouble(widget.info.amount)}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "/year",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: appBlue,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Inter",
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 85.w,
                            height: 25.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: infoRoomsLeftBackground,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Text(
                              widget.info.available
                                  ? "Available"
                                  : "Unavailable",
                              style: context.textTheme.bodySmall!.copyWith(
                                  color: infoRoomsLeft,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HostelExploreCard extends StatefulWidget {
  final HostelInfo info;

  const HostelExploreCard({
    super.key,
    required this.info,
  });

  @override
  State<HostelExploreCard> createState() => _HostelExploreCardState();
}

class _HostelExploreCardState extends State<HostelExploreCard> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.hostelInfo,
        extra: widget.info,
      ),
      child: Card(
        elevation: 1.0,
        child: SizedBox(
          height: 260.h,
          width: 180.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    widget.info.image,
                    width: 180.w,
                    height: 125.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130.w,
                      child: Text(
                        widget.info.name,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => liked = !liked),
                      child: AnimatedSwitcherTranslation.right(
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          Icons.favorite_rounded,
                          color: liked ? Colors.red : weirdBlack25,
                          size: 18,
                          key: ValueKey<bool>(liked),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 180.w,
                  child: Text(
                    joinToAddress(widget.info.address),
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/Hostel Info Bed.svg",
                      width: 15.r,
                      height: 15.r,
                      color: weirdBlack50,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${widget.info.bedrooms}",
                      style: context.textTheme.bodySmall!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      "assets/images/Hostel Info Bath.svg",
                      width: 15.r,
                      height: 15.r,
                      color: weirdBlack50,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${widget.info.bathrooms}",
                      style: context.textTheme.bodySmall!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      "assets/images/Hostel Info Area.svg",
                      width: 15.r,
                      height: 15.r,
                      color: weirdBlack25,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${widget.info.area.toStringAsFixed(0)} sqft",
                      style: context.textTheme.bodySmall!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${currency()} ${formatAmountInDouble(widget.info.price / 1000)}k",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "/year",
                            style: context.textTheme.bodySmall!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 80.w,
                      height: 25.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: infoRoomsLeftBackground,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "${widget.info.roomsLeft.length} room${widget.info.roomsLeft.length == 1 ? "" : "s"} left",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: infoRoomsLeft,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey),
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            RatingStars(
              value: comment.ratings,
              starBuilder: (_, color) => Icon(
                Boxicons.bxs_star,
                color: color,
                size: 18.r,
              ),
              valueLabelVisibility: false,
              starCount: 5,
              starSize: 18.r,
              starSpacing: 5.w,
              starColor: Colors.orange,
              starOffColor: Colors.grey,
            ),
            SizedBox(height: 8.h),
            Text(
              comment.header,
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            if (comment.subtitle.isNotEmpty) SizedBox(height: 8.h),
            if (comment.subtitle.isNotEmpty)
              Text(
                comment.subtitle,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              ),
            SizedBox(height: 8.h),
            Text(
                "${formatDate(DateFormat("dd/MM/yyyy").format(comment.postTime), shorten: true)} "
                "by ${comment.postedBy.mergedNames}"),
            SizedBox(height: 10.h),
          ],
        ),
      ),
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

class RatingsOverview extends StatefulWidget {
  const RatingsOverview({super.key});

  @override
  State<RatingsOverview> createState() => _RatingsOverviewState();
}

class _RatingsOverviewState extends State<RatingsOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.w,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: paleBlue,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 140.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text("0",
                          style: context.textTheme.headlineLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        "/5",
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  RatingStars(
                    value: 3.2,
                    starBuilder: (_, color) => Icon(
                      Boxicons.bxs_star,
                      color: color,
                      size: 14.r,
                    ),
                    valueLabelVisibility: false,
                    starCount: 5,
                    starSize: 14.r,
                    starSpacing: 5.w,
                    starColor: Colors.orange,
                    starOffColor: Colors.grey,
                  ),
                  SizedBox(height: 10.h),
                  Text("0 verified ratings",
                      style: context.textTheme.bodyMedium)
                ],
              ),
            ),
            SizedBox(
              width: 170.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  5,
                  (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${5 - index}",
                          style: context.textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w500)),
                      SizedBox(width: 5.w),
                      Icon(
                        Boxicons.bxs_star,
                        color: Colors.grey,
                        size: 14.r,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "(0)",
                        style: context.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 15.w),
                      SizedBox(
                        width: 90.w,
                        child: LinearProgressIndicator(
                          value: 0.3,
                          minHeight: 10.h,
                          borderRadius: BorderRadius.circular(5.h),
                          color: appBlue,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeSwitcher extends StatefulWidget {
  final Function onHostelDisplayed;
  final Function onRoommateDisplayed;
  final bool initialHostel;
  final bool useDefault;

  const HomeSwitcher({
    super.key,
    this.initialHostel = true,
    this.useDefault = true,
    required this.onHostelDisplayed,
    required this.onRoommateDisplayed,
  });

  @override
  State<HomeSwitcher> createState() => _HomeSwitcherState();
}

class _HomeSwitcherState extends State<HomeSwitcher> {
  late AcquireType type;

  @override
  void initState() {
    super.initState();
    type = widget.initialHostel ? AcquireType.hostel : AcquireType.roommate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (type != AcquireType.hostel) {
              setState(() => type = AcquireType.hostel);
              widget.onHostelDisplayed();
            }
          },
          child: AnimatedSwitcherFlip.flipX(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 185.w,
              height: 50.h,
              alignment: Alignment.center,
              key: ValueKey<bool>(type == AcquireType.hostel),
              decoration: BoxDecoration(
                color:
                    type == AcquireType.hostel ? appBlue : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  bottomLeft: Radius.circular(5.r),
                ),
                border: type == AcquireType.hostel
                    ? null
                    : (widget.useDefault ? Border.all(color: appBlue) : null),
              ),
              child: Text(
                "Hostel",
                style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: type == AcquireType.hostel
                        ? Colors.white
                        : (widget.useDefault ? appBlue : weirdBlack75)),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (type != AcquireType.roommate) {
              setState(() => type = AcquireType.roommate);
              widget.onRoommateDisplayed();
            }
          },
          child: AnimatedSwitcherFlip.flipX(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 185.w,
              height: 50.h,
              alignment: Alignment.center,
              key: ValueKey<bool>(type == AcquireType.roommate),
              decoration: BoxDecoration(
                color:
                    type == AcquireType.roommate ? appBlue : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.r),
                  bottomRight: Radius.circular(5.r),
                ),
                border: type == AcquireType.roommate
                    ? null
                    : (widget.useDefault ? Border.all(color: appBlue) : null),
              ),
              child: Text(
                "Roommate",
                style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: type == AcquireType.roommate
                        ? Colors.white
                        : (widget.useDefault ? appBlue : weirdBlack75)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class RoomTypeCard extends ConsumerWidget {
  final int index;

  const RoomTypeCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 110.r,
      width: 110.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: paleBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55.r,
            width: 90.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset("assets/images/Categories.png"),
          ),
          Text(
            ref.read(roomTypesProvider)[index],
            style: context.textTheme.bodySmall!
                .copyWith(color: weirdBlack, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class AvailableRoomCard extends StatelessWidget {
  final RoomInfo info;
  final bool isAsset;

  const AvailableRoomCard({
    super.key,
    this.isAsset = true,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          elevation: 1.0,
          builder: (_) => SizedBox(
            height: 450.h,
            width: 414.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                            child: SvgPicture.asset(
                                "assets/images/Modal Line.svg"),
                        ),
                        SizedBox(height: 25.h),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            child: isAsset ? Image.asset(
                              info.media[0],
                              width: 414.w,
                              height: 175.h,
                              fit: BoxFit.cover,
                            ) : Image.file(
                              File(info.media[0]),
                              width: 414.w,
                              height: 175.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          info.name,
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: currency(),
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: appBlue,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: formatAmountInDouble(info.price),
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: appBlue,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "/year",
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: appBlue,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Rooms Facilities",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                  SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (_, index) =>
                        FacilityContainer(text: info.facilities[index]),
                    itemCount: info.facilities.length,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          "Gallery",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                  SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.r,
                        mainAxisSpacing: 10.r,
                        mainAxisExtent: 110.r),
                    itemCount: info.media.length,
                    itemBuilder: (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.asset(
                        info.media[index],
                        width: 110.r,
                        height: 110.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 48.h),
                        const Copyright(),
                        SizedBox(height: 24.h)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 185.w,
        height: 205.h,
        decoration: BoxDecoration(
          border: Border.all(color: fadedBorder),
          borderRadius: BorderRadius.circular(10.r),
          color: null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: Image.asset(
                info.media[0],
                fit: BoxFit.cover,
                width: 185.w,
                height: 140.h,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name,
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600, color: weirdBlack),
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: currency(),
                          style: context.textTheme.bodySmall!.copyWith(
                            color: appBlue,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: formatAmountInDouble(info.price),
                          style: context.textTheme.bodySmall!.copyWith(
                            color: appBlue,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "/year",
                          style: context.textTheme.bodySmall!.copyWith(
                            color: appBlue,
                            fontSize: 10.sp,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FacilityContainer extends StatelessWidget {
  final String text;

  const FacilityContainer({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60.r,
          width: 60.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: paleBlue,
          ),
          child: SvgPicture.asset(
            "assets/images/$text.svg",
            width: 35.r,
            height: 35.r,
          ),
        ),
        SizedBox(height: 2.h),
        Text(text, style: context.textTheme.bodyMedium)
      ],
    );
  }
}

class HostelInfoModal extends ConsumerStatefulWidget {
  final HostelInfo info;

  const HostelInfoModal({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<HostelInfoModal> createState() => _HostelInfoModalState();
}

class _HostelInfoModalState extends ConsumerState<HostelInfoModal> {
  late String title, message, image;
  late bool hasEnough, status, selected;

  int? selectedRoom;

  @override
  void initState() {
    super.initState();
    hasEnough = ref.read(walletProvider) >= widget.info.price;
    status = true;
    selected = false;

    if (!hasEnough) {
      title = "Insufficient Balance";
      message = "Please fund your wallet to continue.";
      image = "assets/images/Hostel Pay No Funds.png";
    } else if (status) {
      title = "Hostel Pay Successful";
      message =
          "Congratulations, you have successfully purchased a hostel for yourself.";
      image = "assets/images/Hostel Pay Success.png";
    } else {
      title = "Hostel Pay Failed";
      message = "Your payment was unsuccessful. Please try again.";
      image = "assets/images/Hostel Pay Fail.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: 414.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: CustomScrollView(
          slivers: [
            selected
                ? SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        SvgPicture.asset("assets/images/Modal Line.svg"),
                        SizedBox(height: 25.h),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            child: Image.asset(
                              image,
                              width: 135.r,
                              height: 135.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          title,
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 42.h),
                        if (hasEnough && status)
                          ElevatedButton(
                            onPressed: () => context.router.pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                            ),
                            child: Text(
                              "Ok, thanks",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (hasEnough && !status)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appBlue,
                                ),
                                child: Text(
                                  "Cancel",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appBlue,
                                ),
                                child: Text(
                                  "Try again",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (!hasEnough)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appBlue,
                                ),
                                child: Text(
                                  "Cancel",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    context.router.pushNamed(Pages.topUp),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appBlue,
                                ),
                                child: Text(
                                  "Top-up",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        SvgPicture.asset("assets/images/Modal Line.svg"),
                        SizedBox(height: 25.h),
                        Text(
                          "Choose your room",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Select the room of your choice from the available rooms below",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.w,
                          children: List.generate(
                            widget.info.roomsLeft.length,
                            (index) => GestureDetector(
                              onTap: () => setState(() => selectedRoom = index),
                              child: Container(
                                width: 85.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedRoom != null &&
                                              selectedRoom == index
                                          ? appBlue
                                          : fadedBorder,
                                    ),
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: selectedRoom != null &&
                                            selectedRoom == index
                                        ? paleBlue
                                        : null),
                                child: Text(
                                  widget.info.roomsLeft[index].name,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      color: selectedRoom != null &&
                                              selectedRoom == index
                                          ? appBlue
                                          : weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 42.h),
                        ElevatedButton(
                          onPressed: () => setState(() => selected = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                          ),
                          child: Text(
                            "Pay ${currency()}${formatAmountInDouble(widget.info.price)}",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  const Copyright(),
                  SizedBox(height: 14.h)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String image;
  final String header;
  final String text;

  const ProfileInfoCard({
    super.key,
    required this.image,
    required this.header,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: SizedBox(
        height: 70.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Container(
              width: 50.r,
              height: 50.r,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: paleBlue,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(image),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  header,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                Text(
                  text,
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BasicStudentInfo extends StatelessWidget {
  final Student student;

  const BasicStudentInfo({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileInfoCard(
          image: "assets/images/Profile Level.svg",
          header: "${student.level}",
          text: "School level",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Gender.svg",
          header: student.gender,
          text: "Gender",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Religion.svg",
          header: student.religion,
          text: "Religion",
        ),
        if (student.religion == "Christianity") SizedBox(height: 15.h),
        if (student.religion == "Christianity")
          ProfileInfoCard(
            image: "assets/images/Profile Church.svg",
            header: student.denomination,
            text: "Denomination",
          ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Age.svg",
          header: student.ageRange,
          text: "Age",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Origin.svg",
          header: student.origin,
          text: "State of origin",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Hobby.svg",
          header: student.hobby,
          text: "Hobbies",
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}

class ReceiptContainer extends StatelessWidget {
  final Receipt receipt;

  const ReceiptContainer({
    super.key,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: paleBlue,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "House Rent Proof of Payment",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(height: 14.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "I, ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.studentName,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: ", hereby paid the total sum of ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.amountInWords,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: " for an hostel rent to ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.landOwnerName,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: " as the owner of ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.hostel,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: ".",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "REF: ${receipt.reference}",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${formatDateRaw(receipt.timestamp, shorten: true)}.",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                      SizedBox(height: 4.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 120.w,
                          minHeight: 1.h,
                          maxWidth: 120.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: weirdBlack),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Date Issued",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Oostel",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                      SizedBox(height: 4.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 120.w,
                          minHeight: 1.h,
                          maxWidth: 120.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: weirdBlack),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Authorized",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class PageContent {
  final String header;
  final String subtitle;
  bool visible;
  double amount;

  PageContent({
    required this.header,
    required this.subtitle,
    this.visible = true,
    this.amount = 0.0,
  });
}

class WalletSlider extends ConsumerStatefulWidget {
  const WalletSlider({super.key});

  @override
  ConsumerState<WalletSlider> createState() => _WalletSliderState();
}

class _WalletSliderState extends ConsumerState<WalletSlider> {
  bool showBalance = true, showExpenses = true;

  String amount(int index) {
    double amount =
        (index == 0) ? ref.read(walletProvider) : ref.read(expensesProvider);
    return "${currency()}${formatAmount(amount.toStringAsFixed(0))}";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 414.w,
      height: 145.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => Container(
          width: 270.w,
          height: 145.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: appBlue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total ${index == 0 ? "Balance" : "Expenses"}",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(
                      () {
                        if (index == 0) {
                          showBalance = !showBalance;
                        } else {
                          showExpenses = !showExpenses;
                        }
                      },
                    ),
                    child: AnimatedSwitcherZoom.zoomIn(
                      duration: const Duration(milliseconds: 500),
                      child: SvgPicture.asset(
                        "assets/images/Eye ${((index == 0) ? showBalance : showExpenses) ? "Hidden" : "Visible"}.svg",
                        key: ValueKey<bool>(
                          ((index == 0) ? showBalance : showExpenses),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25.h),
              AnimatedSwitcherTranslation.top(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  ((index == 0) ? showBalance : showExpenses)
                      ? amount(index)
                      : "********",
                  key: ValueKey<bool>(
                      ((index == 0) ? showBalance : showExpenses)),
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Inter",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                index == 0
                    ? "Available funds in wallet"
                    : "Amount spent on acquires",
                style: context.textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (_, __) => SizedBox(width: 20.w),
        itemCount: 2,
      ),
    );
  }
}

class TransactionContainer extends StatelessWidget {
  final Transaction transaction;

  const TransactionContainer({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.transactionDetails,
        extra: transaction,
      ),
      child: Card(
        elevation: 1.0,
        child: SizedBox(
          height: 70.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: paleBlue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/images/Top Up.svg"),
              ),
              SizedBox(width: 15.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transaction.purpose,
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      Text(
                        formatDateWithTime(transaction.timestamp,
                            shorten: true),
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(width: 65.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${transaction.type == TransactionType.credit ? "+" : "-"}"
                        "${currency()}"
                        "${formatAmountInDouble(transaction.amount)}",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      Text(
                        fromStatus(transaction.status),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: transaction.status == TransactionStatus.success
                              ? successColor
                              : (transaction.status == TransactionStatus.failed
                                  ? failColor
                                  : pendingColor),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StudentTransactionDetailsContainer extends StatelessWidget {
  final Transaction transaction;

  const StudentTransactionDetailsContainer({
    super.key,
    required this.transaction,
  });

  Widget rent(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Recipient",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.receiver,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack,
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Paid through",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "Oostel App Wallet",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Payment ID",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.paymentID,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "VAT",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "${currency()}${formatAmountInDouble(transaction.vat)}",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
        ],
      );

  Widget topUp(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bank Name",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.bankName!,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack,
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Account Number",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.accountNumber!,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Account Name",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.receiver,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Received by",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "Oostel App",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Payment ID",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.paymentID,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "VAT",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "${currency()}${formatAmountInDouble(transaction.vat)}",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: paleBlue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/images/Top Up.svg"),
              ),
              SizedBox(width: 15.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transaction.purpose,
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      Text(
                        formatDateWithTime(transaction.timestamp,
                            shorten: true),
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(width: 65.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${transaction.type == TransactionType.credit ? "+" : "-"}"
                        "${currency()}"
                        "${formatAmountInDouble(transaction.amount)}",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      Text(
                        fromStatus(transaction.status),
                        style: context.textTheme.bodyMedium!.copyWith(
                            color:
                                transaction.status == TransactionStatus.success
                                    ? successColor
                                    : (transaction.status ==
                                            TransactionStatus.failed
                                        ? failColor
                                        : pendingColor),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 24.h),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 320.w,
              minHeight: 1.h,
              maxWidth: 320.w,
              maxHeight: 1.h,
            ),
            child: const ColoredBox(color: Colors.black12),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: transaction.purpose == "Hostel Payment"
                ? rent(context)
                : (transaction.purpose == "Top-up Wallet")
                    ? topUp(context)
                    : const SizedBox(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class OwnerTransactionDetailsContainer extends StatelessWidget {
  final Transaction transaction;

  const OwnerTransactionDetailsContainer({
    super.key,
    required this.transaction,
  });

  Widget rent(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sender's name",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.receiver,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack,
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Paid for",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.hostel!,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Paid through",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "Oostel App",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Payment ID",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.paymentID,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "VAT",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "${currency()}${formatAmountInDouble(transaction.vat)}",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
        ],
      );

  Widget topUp(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bank Name",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.bankName!,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack,
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Account Number",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.accountNumber!,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Account Name",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.receiver,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sent from",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "Oostel App Wallet",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Payment ID",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                transaction.paymentID,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "VAT",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              Text(
                "${currency()}${formatAmountInDouble(transaction.vat)}",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
              )
            ],
          ),
          SizedBox(height: 12.h),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          if (transaction.purpose == "Withdrawal")
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 30.r,
                            minHeight: 30.r,
                            maxWidth: 30.r,
                            maxHeight: 30.r,
                          ),
                          child: ColoredBox(
                            color: successColor,
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 80.w,
                          minHeight: 1.5.h,
                          maxWidth: 80.w,
                          maxHeight: 1.5.h,
                        ),
                        child: const ColoredBox(color: successColor),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 30.r,
                            minHeight: 30.r,
                            maxWidth: 30.r,
                            maxHeight: 30.r,
                          ),
                          child: ColoredBox(
                            color: successColor,
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 80.w,
                          minHeight: 1.5.h,
                          maxWidth: 80.w,
                          maxHeight: 1.5.h,
                        ),
                        child: const ColoredBox(color: successColor),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 30.r,
                            minHeight: 30.r,
                            maxWidth: 30.r,
                            maxHeight: 30.r,
                          ),
                          child: ColoredBox(
                            color: successColor,
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Payment",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                            Text(
                              "Successful",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Processing",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                            Text(
                              "by bank",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Received",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                            Text(
                              "by bank",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 320.w,
                    minHeight: 1.h,
                    maxWidth: 320.w,
                    maxHeight: 1.h,
                  ),
                  child: const ColoredBox(color: Colors.black12),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: paleBlue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/images/Top Up.svg"),
              ),
              SizedBox(width: 15.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transaction.purpose,
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      Text(
                        formatDateWithTime(transaction.timestamp,
                            shorten: true),
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: transaction.purpose == "Money Received"
                          ? 55.w
                          : 85.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${transaction.type == TransactionType.credit ? "+" : "-"}"
                        "${currency()}"
                        "${formatAmountInDouble(transaction.amount)}",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      Text(
                        fromStatus(transaction.status),
                        style: context.textTheme.bodyMedium!.copyWith(
                            color:
                                transaction.status == TransactionStatus.success
                                    ? successColor
                                    : (transaction.status ==
                                            TransactionStatus.failed
                                        ? failColor
                                        : pendingColor),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 24.h),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 320.w,
              minHeight: 1.h,
              maxWidth: 320.w,
              maxHeight: 1.h,
            ),
            child: const ColoredBox(color: Colors.black12),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: transaction.purpose == "Money Received"
                ? rent(context)
                : (transaction.purpose == "Withdrawal")
                    ? topUp(context)
                    : const SizedBox(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

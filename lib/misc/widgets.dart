import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_hostel/components/comment.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

export 'package:flutter_spinkit/flutter_spinkit.dart';

class Holder {
  final String content;
  bool selected;

  Holder({
    required this.content,
    this.selected = false,
  });
}

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

class SizedBoxHeaderDelegate extends SliverPersistentHeaderDelegate {
  SizedBoxHeaderDelegate({required this.box});

  final SizedBox box;

  @override
  double get minExtent => box.height!;

  @override
  double get maxExtent => box.height!;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      box;

  @override
  bool shouldRebuild(SizedBoxHeaderDelegate oldDelegate) => false;
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
              context.textTheme.bodyMedium!.copyWith(color: weirdBlack25),
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
        extra: widget.info.toJson(),
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
                          style: context.textTheme.bodySmall!
                              .copyWith(color: weirdBlack50),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset("assets/images/Hostel Info Bath.svg",
                            width: 15.r, height: 15.r, color: weirdBlack50),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.bathrooms}",
                          style: context.textTheme.bodySmall!
                              .copyWith(color: weirdBlack50),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset("assets/images/Hostel Info Area.svg",
                            width: 15.r, height: 15.r, color: weirdBlack25),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.area.toStringAsFixed(0)} sqft",
                          style: context.textTheme.bodySmall!
                              .copyWith(color: weirdBlack50),
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
                                  text: currency(),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: formatAmountInDouble(widget.info.price),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: "/year",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: appBlue,
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
                              ),
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

class RoommateInfoCard extends StatefulWidget {
  final RoommateInfo info;

  const RoommateInfoCard({
    super.key,
    required this.info,
  });

  @override
  State<RoommateInfoCard> createState() => _RoommateInfoCardState();
}

class _RoommateInfoCardState extends State<RoommateInfoCard> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.otherStudent,
        extra: widget.info.toJson(),
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
                  backgroundImage: AssetImage(widget.info.student.image),
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
                            widget.info.student.mergedNames,
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600, color: weirdBlack),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => liked = !liked),
                            child: AnimatedSwitcherTranslation.right(
                              duration: const Duration(milliseconds: 500),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: liked ? Colors.red : Colors.black26,
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
                          color: Colors.black45,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.info.student.gender,
                          style: context.textTheme.bodySmall!
                              .copyWith(color: weirdBlack),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(
                          "assets/images/Roomate Info Level.svg",
                          width: 15.r,
                          height: 15.r,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "${widget.info.level} level",
                          style: context.textTheme.bodySmall!
                              .copyWith(color: weirdBlack),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(
                          "assets/images/Roomate Info Location.svg",
                          width: 15.r,
                          height: 15.r,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.info.location,
                          style: context.textTheme.bodySmall!
                              .copyWith(color: weirdBlack),
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
                                  text: currency(),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      formatAmountInDouble(widget.info.amount),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: "/year",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: appBlue,
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
                              ),
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
        extra: widget.info.toJson(),
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
                          color: liked ? Colors.red : Colors.black26,
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
                    widget.info.address,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack, fontWeight: FontWeight.w500),
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
                      color: weirdBlack,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${widget.info.bedrooms}",
                      style: context.textTheme.bodySmall!
                          .copyWith(color: weirdBlack),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      "assets/images/Hostel Info Bath.svg",
                      width: 15.r,
                      height: 15.r,
                      color: weirdBlack,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${widget.info.bathrooms}",
                      style: context.textTheme.bodySmall!
                          .copyWith(color: weirdBlack),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      "assets/images/Hostel Info Area.svg",
                      width: 15.r,
                      height: 15.r,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${widget.info.area.toStringAsFixed(0)} sqft",
                      style: context.textTheme.bodySmall!
                          .copyWith(color: weirdBlack),
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
                            text: currency(),
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                "${formatAmountInDouble(widget.info.price / 1000)}k",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "/year",
                            style: context.textTheme.bodySmall!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontSize: 10.sp,
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
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

  const AvailableRoomCard({
    super.key,
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
                        SizedBox(height: 25.h),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            child: Image.asset(
                              info.media[0],
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

import 'dart:io';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/components/comment.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/pages/other/gallery.dart';

import 'common.dart';



class ProfileNotification extends ConsumerStatefulWidget {
  final VoidCallback onCancel;

  const ProfileNotification({super.key, required this.onCancel});

  @override
  ConsumerState<ProfileNotification> createState() =>
      _ProfileNotificationState();
}

class _ProfileNotificationState extends ConsumerState<ProfileNotification> {
  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);

    return Container(
      height: 140.h,
      width: 414.w,
      color: user.hasCompletedProfile < 100
          ? incompleteBackground
          : completeBackground,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user.hasCompletedProfile < 100
                    ? "Complete your Profile"
                    : "Profile Completed!",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              GestureDetector(
                onTap: widget.onCancel,
                child: Icon(
                  Boxicons.bx_x,
                  color: weirdBlack,
                  size: 26.r,
                ),
              )
            ],
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: user.hasCompletedProfile < 100
                      ? "You are ${user.hasCompletedProfile}% done from unlocking the full potential of your account. "
                      : "Congratulations! You have unlocked the full potential of your account. ",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: weirdBlack75),
                ),
                if (user.hasCompletedProfile < 100)
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Click ",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack75,
                        ),
                      ),
                      TextSpan(
                        text: "here",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: appBlue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.router.pushNamed(
                            ref.watch(isAStudent)
                                ? Pages.editProfile
                                : ref.watch(isLandlord)
                                ? Pages.editOwnerProfile
                                : Pages.editAgentProfile,
                          ),
                      )
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          LinearProgressIndicator(
            color: user.hasCompletedProfile < 100 ? incompleteBar : completeBar,
            value: user.hasCompletedProfile * 0.01,
            backgroundColor: incompleteFadedBar,
            minHeight: 10.h,
            borderRadius: BorderRadius.circular(5.r),
          )
        ],
      ),
    );
  }
}

class HostelInfoCard extends ConsumerStatefulWidget {
  final HostelInfo info;

  const HostelInfoCard({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<HostelInfoCard> createState() => _HostelInfoCardState();
}

class _HostelInfoCardState extends ConsumerState<HostelInfoCard> {
  late int bedrooms, bathrooms;

  @override
  void initState() {
    super.initState();
    List<int> props = calculate(widget.info.rooms);
    bathrooms = props[0];
    bedrooms = widget.info.rooms.length;
  }

  @override
  Widget build(BuildContext context) {
    List<String> likes = ref.watch(studentLikedHostelsProvider);
    String id = ref.watch(currentUserProvider).id;

    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.hostelInfo,
        extra: widget.info,
      ),
      child: SizedBox(
        height: 135.h,
        child: Center(
          child: Container(
            width: 400.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(4.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFE0E5EC),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
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
                        "Hostel ID: ${widget.info.id} Image: ${widget.info.media.first}",
                        child: CachedNetworkImage(
                          imageUrl: widget.info.media.first,
                          errorWidget: (context, url, error) => Container(
                            height: 100.h,
                            width: 125.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: weirdBlack25,
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, download) =>
                              Container(
                                  height: 100.h,
                                  width: 125.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: weirdBlack25,
                                  ),
                                  alignment: Alignment.center,
                                  child: loader),
                          imageBuilder: (context, provider) => Container(
                            height: 100.h,
                            width: 125.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: provider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                                  onTap: () {
                                    if (likes.contains(id)) {
                                      likes.remove(id);
                                    } else {
                                      likes.add(id);
                                    }
                                    setState(() {});
                                  },
                                  child: AnimatedSwitcherTranslation.right(
                                    duration: const Duration(milliseconds: 500),
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: likes.contains(id)
                                          ? Colors.red
                                          : weirdBlack20,
                                      size: 18,
                                      key: ValueKey<bool>(
                                        likes.contains(id),
                                      ),
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
                              "$bedrooms",
                              style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 12.w),
                            SvgPicture.asset(
                                "assets/images/Hostel Info Bath.svg",
                                width: 15.r,
                                height: 15.r,
                                color: weirdBlack50),
                            SizedBox(width: 5.w),
                            Text(
                              "$bathrooms",
                              style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 12.w),
                            SvgPicture.asset(
                                "assets/images/Hostel Info Area.svg",
                                width: 15.r,
                                height: 15.r,
                                color: weirdBlack25),
                            SizedBox(width: 5.w),
                            Text(
                              "${widget.info.area.toStringAsFixed(0)} sqft",
                              style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                                      style:
                                      context.textTheme.bodySmall!.copyWith(
                                        color: appBlue,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "/year",
                                      style:
                                      context.textTheme.bodySmall!.copyWith(
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
                                  "${widget.info.rooms.length}/${widget.info.totalRooms} room${widget.info.totalRooms == 1 ? "" : "s"} left",
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
        ),
      ),
    );
  }
}

class StudentCard extends ConsumerStatefulWidget {
  final Student info;

  const StudentCard({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends ConsumerState<StudentCard> {
  @override
  Widget build(BuildContext context) {
    List<String> likes = ref.watch(studentLikedRoommatesProvider);
    String id = ref.watch(currentUserProvider).id;

    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.otherStudent,
        extra: widget.info,
      ),
      child: Container(
        width: 400.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E5EC),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: SizedBox(
          height: 120.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.info.image),
                  radius: 35.w,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 270.w,
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
                            onTap: () {
                              if (likes.contains(id)) {
                                likes.remove(id);
                              } else {
                                likes.add(id);
                              }
                            },
                            child: AnimatedSwitcherTranslation.right(
                              duration: const Duration(milliseconds: 500),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: likes.contains(id)
                                    ? Colors.red
                                    : weirdBlack25,
                                size: 18,
                                key: ValueKey<bool>(likes.contains(id)),
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
                      width: 270.w,
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

class HostelExploreCard extends ConsumerStatefulWidget {
  final HostelInfo info;

  const HostelExploreCard({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<HostelExploreCard> createState() => _HostelExploreCardState();
}

class _HostelExploreCardState extends ConsumerState<HostelExploreCard> {
  late int bathroom, bedrooms;

  @override
  void initState() {
    super.initState();
    List<int> props = calculate(widget.info.rooms);
    bathroom = props[0];
    bedrooms = widget.info.rooms.length;
  }

  @override
  Widget build(BuildContext context) {
    List<String> likes = ref.watch(studentLikedHostelsProvider);
    String id = ref.watch(currentUserProvider).id;
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.hostelInfo,
        extra: widget.info,
      ),
      child: SizedBox(
        height: 270.h,
        child: Center(
          child: Container(
            height: 250.h,
            width: 180.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(4.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFE0E5EC),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                  widget.info.media.isEmpty ? "" : widget.info.media.first,
                  errorWidget: (context, url, error) => Container(
                    width: 180.w,
                    height: 125.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: weirdBlack25,
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, download) =>
                      Container(
                          width: 180.w,
                          height: 125.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: weirdBlack25,
                          ),
                          alignment: Alignment.center,
                          child: loader),
                  imageBuilder: (context, provider) => Container(
                    width: 180.w,
                    height: 125.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: provider,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                      onTap: () {
                        likeHostel({});

                        if (likes.contains(id)) {
                          likes.remove(id);
                        } else {
                          likes.add(id);
                        }
                        setState(() {});
                      },
                      child: AnimatedSwitcherTranslation.right(
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          Icons.favorite_rounded,
                          color:
                          likes.contains(ref.read(currentUserProvider).id)
                              ? Colors.red
                              : weirdBlack25,
                          size: 18,
                          key: ValueKey<bool>(
                            likes.contains(id),
                          ),
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
                    SizedBox(width: 4.w),
                    Text(
                      "$bedrooms",
                      style: context.textTheme.bodySmall!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(
                      "assets/images/Hostel Info Bath.svg",
                      width: 15.r,
                      height: 15.r,
                      color: weirdBlack50,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "$bathroom",
                      style: context.textTheme.bodySmall!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(
                      "assets/images/Hostel Info Area.svg",
                      width: 15.r,
                      height: 15.r,
                      color: weirdBlack25,
                    ),
                    SizedBox(width: 4.w),
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
                        "${widget.info.rooms.length}/${widget.info.totalRooms} room${widget.info.totalRooms == 1 ? "" : "s"} left",
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

class CommentCard extends StatefulWidget {
  final Comment comment;
  final bool isStudentSection;

  const CommentCard(
      {super.key, required this.comment, this.isStudentSection = false});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final TextEditingController commentController = TextEditingController();

  bool expand = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: weirdBlack.withOpacity(0.15)),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingStars(
                      value: widget.comment.ratings,
                      starBuilder: (_, color) => Icon(
                        Boxicons.bxs_star,
                        color: color,
                        size: 18.r,
                      ),
                      valueLabelVisibility: false,
                      starCount: 5,
                      starSize: 18.r,
                      starSpacing: 5.w,
                      starColor: accentYellowColor,
                      starOffColor: weirdBlack.withOpacity(0.1),
                    ),
                    if (!widget.isStudentSection)
                      GestureDetector(
                        onTap: () {
                          setState(() => expand = !expand);
                          if (expand) {
                            controller.forward();
                          } else {
                            controller.reverse();
                          }
                        },
                        child: Text(
                          expand ? "Cancel" : "Reply",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue, fontWeight: FontWeight.w500),
                        ),
                      )
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.comment.header,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                if (widget.comment.subtitle.isNotEmpty) SizedBox(height: 8.h),
                if (widget.comment.subtitle.isNotEmpty)
                  Text(
                    widget.comment.subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: weirdBlack),
                  ),
                SizedBox(height: 8.h),
                Text(
                    "${formatDate(DateFormat("dd/MM/yyyy").format(widget.comment.postTime), shorten: true)} "
                        "by ${widget.comment.postedBy.mergedNames}",
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack.withOpacity(0.4))),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          if (!widget.isStudentSection)
            SizeTransition(
                sizeFactor: animation,
                child: ColoredBox(
                    color: paleBlue,
                    child: SizedBox(
                      height: 60.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SpecialForm(
                              controller: commentController,
                              width: 300.w,
                              height: 45.h,
                              hint: "Add your message...",
                              suffix: const Icon(Icons.emoji_emotions_rounded,
                                  color: appBlue),
                              fillColor: Colors.white,
                              borderColor: Colors.transparent,
                              radius: BorderRadius.circular(22.5.h),
                            ),
                            GestureDetector(
                                child: Icon(Icons.send_rounded,
                                    color: appBlue, size: 26.r)),
                          ],),
                    ),),),
        ],
      ),
    );
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
                  RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "0",
                              style: context.textTheme.headlineLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: "/5",
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
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
                    starColor: accentYellowColor,
                    starOffColor: weirdBlack.withOpacity(0.1),
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
                        color: weirdBlack.withOpacity(0.1),
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
                          minHeight: 8.h,
                          borderRadius: BorderRadius.circular(5.h),
                          color: accentYellowColor,
                          backgroundColor: weirdBlack.withOpacity(0.1),
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

  String get name {
    if (index == 0) {
      return "Self Con";
    } else if (index == 1) {
      return "One Room";
    } else if (index == 2) {
      return "Face2Face";
    } else if (index == 3) {
      return "Flat";
    }
    return "";
  }

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
                image: DecorationImage(
                  image: AssetImage("assets/images/$name.png"),
                  fit: BoxFit.cover,
                )),
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

class AvailableRoomCard extends StatefulWidget {
  final RoomInfo? info;
  final RoomInfoData? infoData;
  final Map<String, dynamic>? infoMap;
  final bool available;
  final VoidCallback? onTap;
  final DateTime? expiry;
  final bool fromStudent;

  const AvailableRoomCard({
    super.key,
    this.fromStudent = false,
    this.available = false,
    this.info,
    this.infoData,
    this.infoMap,
    this.expiry,
    this.onTap,
  });

  @override
  State<AvailableRoomCard> createState() => _AvailableRoomCardState();
}

class _AvailableRoomCardState extends State<AvailableRoomCard> {
  late Color backgroundColor, textColor;
  late String deadline;

  bool timeUp = false, isData = false, available = false;

  @override
  void initState() {
    super.initState();

    if (widget.info == null &&
        (widget.infoMap != null || widget.infoData != null)) {
      isData = true;
      if (widget.infoMap != null) {
        available = true;
      } else if (widget.infoData != null) {
        available = !widget.infoData!.isRented;
      }
      return;
    } else {
      available = !widget.info!.isRented;
    }

    timeUp = widget.fromStudent;

    DateTime expiry = DateTime(2024, 10, 25);
    DateTime current = DateTime.now();

    Jiffy first = Jiffy.parseFromDateTime(current),
        second = Jiffy.parseFromDateTime(expiry);

    int days = second.diff(first, unit: Unit.day).toInt();
    int months = second.diff(first, unit: Unit.month).toInt();

    if (months > 4) {
      deadline = "$months months";
      backgroundColor = infoRoomsLeftBackground;
      textColor = infoRoomsLeft;
    } else if (months >= 1 && months <= 4) {
      deadline = "$months months";
      backgroundColor = yellowDeadlineBackground;
      textColor = pendingColor;
    } else {
      deadline = "$days days";
      backgroundColor = redDeadlineBackground;
      textColor = failColor;
    }
  }

  void showRoomInfoSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 1.0,
      builder: (_) => SizedBox(
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
                      child: SvgPicture.asset("assets/images/Modal Line.svg"),
                    ),
                    SizedBox(height: 25.h),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.info!.media.first,
                          errorWidget: (context, url, error) => Container(
                            width: 414.w,
                            height: 175.h,
                            color: weirdBlack50,
                            alignment: Alignment.center,
                            child: loader,
                          ),
                          progressIndicatorBuilder: (context, url, download) =>
                              Container(
                                width: 414.w,
                                height: 175.h,
                                color: weirdBlack50,
                              ),
                          imageBuilder: (context, provider) => Container(
                            width: 414.w,
                            height: 175.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: provider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      isData ? widget.infoMap!["name"] : widget.info!.name,
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
                            text: formatAmountInDouble(isData
                                ? widget.infoMap!["price"]
                                : widget.info!.price),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5.r,
                  mainAxisSpacing: 15.r,
                  mainAxisExtent: 105.r,
                ),
                itemBuilder: (_, index) =>
                    FacilityContainer(text: widget.info!.facilities[index]),
                itemCount: widget.info!.facilities.length,
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
                itemCount: widget.info!.media.length,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () => context.router.pushNamed(
                    Pages.viewMedia,
                    extra: ViewInfo(
                      type: DisplayType.network,
                      paths: widget.info!.media,
                      current: index,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.info!.media[index],
                    errorWidget: (context, url, error) => Container(
                      width: 110.r,
                      height: 110.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: weirdBlack50,
                      ),
                      alignment: Alignment.center,
                      child: loader,
                    ),
                    progressIndicatorBuilder: (context, url, download) =>
                        Container(
                          width: 110.r,
                          height: 110.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: weirdBlack50,
                          ),
                        ),
                    imageBuilder: (context, provider) => Container(
                      width: 110.r,
                      height: 110.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        image: DecorationImage(
                          image: provider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isLocalFirst {
    if (widget.info != null) return false;
    if (widget.infoMap != null) return true;
    return widget.infoData!.media.first! is String;
  }

  String get name {
    if (widget.info != null) return widget.info!.name;
    if (widget.infoMap != null) return widget.infoMap!["name"];
    return widget.infoData!.name;
  }

  double get price {
    if (widget.info != null) return widget.info!.price;
    if (widget.infoMap != null) return widget.infoMap!["price"];
    return widget.infoData!.price;
  }

  File get localFile => File(widget.infoMap != null
      ? widget.infoMap!["media"].first.path
      : widget.infoData!.media.first.path);

  String get onlineUrl => widget.info != null
      ? widget.info!.media.first
      : widget.infoData!.media.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? showRoomInfoSheet,
      child: Container(
        width: 185.w,
        height: 215.h,
        decoration: BoxDecoration(
          border: Border.all(color: fadedBorder, width: 0.5),
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLocalFirst
                    ? Container(
                  width: 185.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                    image: DecorationImage(
                      image: FileImage(localFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : CachedNetworkImage(
                  imageUrl: onlineUrl,
                  errorWidget: (context, url, error) => Container(
                    width: 185.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      color: weirdBlack25,
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, download) =>
                      Container(
                        width: 185.w,
                        height: 140.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                          ),
                          color: weirdBlack25,
                        ),
                      ),
                  imageBuilder: (context, provider) => Container(
                    width: 185.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      image: DecorationImage(
                        image: provider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: timeUp ? 150.w : 80.w,
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                          ),
                          if (!timeUp && !isData)
                            Container(
                              width: 70.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                deadline,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                        ],
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
                              text: formatAmountInDouble(price),
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
                ),
              ],
            ),
            if (available)
              Positioned(
                top: 10.r,
                left: 10.r,
                child: Container(
                  width: 60.w,
                  height: 25.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: infoRoomsLeftBackground,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "Available",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: infoRoomsLeft,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
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
          height: 80.r,
          width: 80.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: paleBlue,
          ),
          child: SvgPicture.asset(
            "assets/images/${text == "None" ? "None" : "$text-On"}.svg",
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

  late List<RoomInfo> availableRooms;

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

    availableRooms = [];
    for (RoomInfo room in widget.info.rooms) {
      if (room.isRented) {
        availableRooms.add(room);
      }
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
                  SizedBox(height: 55.h),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: appBlue,
                        ),
                        child: Text(
                          "Ok, thanks",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  if (hasEnough && !status)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 170.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: appBlue),
                            ),
                            child: Text(
                              "Cancel",
                              style:
                              context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appBlue,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 170.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: appBlue,
                            ),
                            child: Text(
                              "Try again",
                              style:
                              context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!hasEnough)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 170.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: appBlue),
                            ),
                            child: Text(
                              "Cancel",
                              style:
                              context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appBlue,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.router.pushNamed(Pages.topUp),
                          child: Container(
                            width: 170.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: appBlue,
                            ),
                            child: Text(
                              "Top-up",
                              style:
                              context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      availableRooms.length,
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
                            availableRooms[index].name,
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
                  GestureDetector(
                    onTap: () => setState(() => selected = true),
                    child: Container(
                      width: 414.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appBlue,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "Pay ${currency()}${formatAmountInDouble(widget.info.price)}",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

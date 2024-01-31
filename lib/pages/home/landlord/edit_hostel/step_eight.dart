import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/edit-hostel.dart';


class EditStepEight extends StatefulWidget {
  final HostelInfoData info;

  const EditStepEight({
    super.key,
    required this.info,
  });

  @override
  State<EditStepEight> createState() => _EditStepEightState();
}

class _EditStepEightState extends State<EditStepEight> {
  bool exists(int index) => index < widget.info.rooms.length;
  int totalCards = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 9 / totalPages,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: "Reset",
                    child: Text(
                      "Save and Exit",
                      style: context.textTheme.bodyMedium,
                    ),
                  )
                ],
                onSelected: (result) =>
                    saveAndExit(info: widget.info, context: context),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "STEP 9",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: appBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Room Vacancy",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Showcase your available hostel rooms with an attractive vacancy presentation. "
                      "Make your listing stand out to potential tenants.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                Column(
                  children: List.generate(
                    totalCards + 1,
                        (index) {
                      if (index == totalCards) {
                        return Column(
                          children: [
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: () {
                                if (exists(totalCards - 1)) {
                                  setState(() => ++totalCards);
                                } else {
                                  showError(
                                      "Please create a room with the card(s) above");
                                }
                              },
                              child: Container(
                                width: 160.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: paleBlue,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_circle_outline,
                                        color: appBlue, size: 16),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Add room",
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        color: appBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                          ],
                        );
                      }

                      return !exists(index)
                          ? GestureDetector(
                        onTap: () {
                          widget.info.roomEditIndex = null;
                          context.router
                              .pushNamed(Pages.stepNine,
                              extra: widget.info)
                              .then(
                                (value) => setState(
                                  () {
                                if (value == null) return;
                                widget.info.rooms
                                    .add(value as RoomInfoData);
                              },
                            ),
                          );
                        },
                        child: const _NoRoom(),
                      )
                          : GestureDetector(
                        onTap: () {
                          widget.info.roomEditIndex = index;
                          context.router
                              .pushNamed(Pages.stepNine,
                              extra: widget.info)
                              .then((value) => setState(() {}));
                        },
                        child: _CreateRoomCard(
                            info: widget.info.rooms[index]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: appBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left_rounded,
                        color: appBlue, size: 26.r),
                    SizedBox(width: 5.w),
                    Text(
                      "Go back",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: appBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.info.rooms.isEmpty) {
                  showError("Please create at least one room");
                  return;
                }
                saveAndExit(info: widget.info, context: context);
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: widget.info.rooms.isEmpty
                      ? appBlue.withOpacity(0.4)
                      : appBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 26.r)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoRoom extends StatelessWidget {
  const _NoRoom();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: Center(
        child: Container(
          width: 350.w,
          height: 200.h,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: paleBlue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/Create Room.svg",
                width: 40.r,
                height: 40.r,
              ),
              SizedBox(height: 8.h),
              Text(
                "Create room",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: weirdBlack75,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateRoomCard extends StatelessWidget {
  final RoomInfoData info;

  const _CreateRoomCard({
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FBFF),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFE0E5EC),
                blurRadius: 6.0,
                spreadRadius: 1.0,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  info.isLocal(0)
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(info.media.first.path),
                      width: 414.w,
                      height: 156.h,
                      fit: BoxFit.cover,
                    ),
                  )
                      : CachedNetworkImage(
                    imageUrl: info.media.first,
                    errorWidget: (context, url, error) => Container(
                      width: 414.w,
                      height: 156.h,
                      color: weirdBlack50,
                    ),
                    progressIndicatorBuilder: (context, url, download) =>
                        Container(
                          width: 414.w,
                          height: 156.h,
                          color: weirdBlack50,
                          alignment: Alignment.center,
                          child: loader,
                        ),
                    imageBuilder: (context, provider) => Container(
                      width: 414.w,
                      height: 156.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: provider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15.h,
                    left: 15.w,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: infoRoomsLeftBackground,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "Available",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: infoRoomsLeft,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                info.name,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "This room will be made available for the students to rent and partner with their friends if requested.",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 6.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${currency()} ${formatAmountInDouble(info.price)}",
                      style: context.textTheme.bodyLarge!.copyWith(
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
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
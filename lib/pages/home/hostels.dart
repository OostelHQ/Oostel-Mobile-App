import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/comment.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

class HostelInformationPage extends StatefulWidget {
  final HostelInfo info;

  const HostelInformationPage({super.key, required this.info});

  @override
  State<HostelInformationPage> createState() => _HostelInformationPageState();
}

class _HostelInformationPageState extends State<HostelInformationPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  late List<Comment> comments;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this, initialIndex: 2);

    Student student = const Student(
      firstName: "Elizabeth",
      lastName: "Enitan",
      image: "assets/images/watch man.jpg",
    );

    DateTime now = DateTime.now();

    comments = [
      Comment(
        header: "Nice Hostel",
        subtitle: "I like this hostel a lot...",
        postedBy: student,
        postTime: now,
      ),
      Comment(
        header: "Wow",
        subtitle: "Hmmn...",
        postedBy: student,
        postTime: now,
      ),
      Comment(
        header: "Nice",
        subtitle: "",
        postedBy: student,
        postTime: now,
      ),
      Comment(
        header: "Bala Blu",
        subtitle: "I like this hostel a lot...",
        postedBy: student,
        postTime: now,
      ),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.info.image,
                  width: 414.w,
                  height: 470.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 80.h,
                  left: 30.w,
                  child: GestureDetector(
                    onTap: () => context.router.pop(),
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.chevron_left_rounded,
                          color: Colors.white, size: 26.r),
                    ),
                  ),
                ),
                Positioned(
                  top: 80.h,
                  right: 30.w,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.favorite_rounded,
                          color: Colors.red, size: 26.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 280.w,
                        child: Text(
                          widget.info.name,
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
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
                          "${widget.info.roomsLeft} room${widget.info.roomsLeft == 1 ? "" : "s"} left",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: infoRoomsLeft,
                            fontSize: 13.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    widget.info.address,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
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
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: currency(),
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: appBlue,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: formatAmountInDouble(widget.info.price),
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: appBlue,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "/year",
                              style: context.textTheme.bodySmall!.copyWith(
                                color: appBlue,
                                fontFamily: "Inter",
                              ),
                            )
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22.5.r),
                        child: Image.asset(
                          "assets/images/funaab logo.png",
                          width: 50.r,
                          height: 50.r,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TabBar(
                    controller: controller,
                    indicatorColor: appBlue,
                    labelColor: appBlue,
                    labelStyle: context.textTheme.bodyMedium!
                        .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: context.textTheme.bodyMedium!
                        .copyWith(
                            color: Colors.black45, fontWeight: FontWeight.w500),
                    tabs: const [
                      Tab(text: "Landlord"),
                      Tab(text: "Details"),
                      Tab(text: "Comments")
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 550.h,
              child: TabBarView(
                controller: controller,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(widget.info.owner.image),
                              radius: 42.r,
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              height: 85.h,
                              width: 280.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          "${widget.info.owner.firstName} ${widget.info.owner.lastName}",
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: weirdBlack),
                                        ),
                                      ),
                                      if (widget.info.owner.verified)
                                        Container(
                                          width: 70.w,
                                          height: 25.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: paleBlue,
                                            borderRadius:
                                                BorderRadius.circular(12.5.h),
                                          ),
                                          child: Text(
                                            "Verified",
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                              color: appBlue,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.info.owner.contact,
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                                color: weirdBlack,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RatingStars(
                                              value: widget.info.owner.ratings,
                                              starBuilder: (_, color) => Icon(
                                                Boxicons.bxs_star,
                                                color: color,
                                                size: 14.r,
                                              ),
                                              valueLabelVisibility: false,
                                              starCount: 4,
                                              starSize: 14.r,
                                              starSpacing: 5.w,
                                              starColor: Colors.orange,
                                            ),
                                            Text(
                                              "(${widget.info.owner.totalRated})",
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(color: weirdBlack),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/Roomate Info Location.svg",
                                            width: 15.r,
                                            height: 15.r,
                                            color: Colors.black45,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            widget.info.owner.address,
                                            style: context.textTheme.bodySmall!
                                                .copyWith(
                                                    color: weirdBlack,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Registered since ${widget.info.owner.dateJoined.year}",
                                        style: context.textTheme.bodySmall!
                                            .copyWith(
                                                color: weirdBlack,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        width: 414.w,
                        height: 90.h,
                        color: paleBlue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 180.w,
                                height: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5.r),
                                  border:
                                      Border.all(color: appBlue, width: 1.5),
                                ),
                                child: Text(
                                  "Start a chat",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: appBlue),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 180.w,
                                height: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: appBlue,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Text(
                                  "Pay",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                widget.info.description,
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: weirdBlack),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Rules & Regulations",
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack),
                              ),
                              SizedBox(height: 8.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  widget.info.rules.length,
                                  (index) => Text(
                                      "${index + 1}. ${widget.info.rules[index]}"),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Facilities",
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack),
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                height: 85.r,
                                child: ListView.separated(
                                  itemCount: widget.info.facilities.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 24.w),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60.r,
                                        width: 60.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          color: paleBlue,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/${widget.info.facilities[index]}.svg",
                                          width: 35.r,
                                          height: 35.r,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(widget.info.facilities[index],
                                          style: context.textTheme.bodyMedium)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Gallery",
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack),
                              ),
                              SizedBox(
                                height: 450.h,
                                child: GridView.builder(
                                  itemCount: widget.info.media.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 14.w,
                                    mainAxisSpacing: 14.h,
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (_, index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Image.asset(
                                      widget.info.media[index],
                                      width: 110.r,
                                      height: 110.r,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Container(
                                width: 414.w,
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: paleBlue,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 140.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.end,
                                              children: [
                                                Text("0",
                                                    style: context.textTheme
                                                        .headlineLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                Text(
                                                  "/5",
                                                  style: context
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                style: context
                                                    .textTheme.bodyMedium)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            5,
                                            (index) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text("${5 - index}",
                                                    style: context
                                                        .textTheme.bodySmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                SizedBox(width: 5.w),
                                                Icon(
                                                  Boxicons.bxs_star,
                                                  color: Colors.grey,
                                                  size: 14.r,
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  "(0)",
                                                  style: context
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                SizedBox(width: 15.w),
                                                SizedBox(
                                                  width: 90.w,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: 0.3,
                                                    minHeight: 10.h,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.h),
                                                    color: appBlue,
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.5),
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
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Comment from students",
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: weirdBlack),
                                  ),
                                  SizedBox(
                                    height: 400.h,
                                    child: comments.isEmpty
                                        ? Center(
                                            child: Text(
                                                "There are no comments yet. Be the first to make a comment",
                                                textAlign: TextAlign.center,
                                                style: context
                                                    .textTheme.bodyMedium),
                                          )
                                        : ListView.separated(
                                            itemBuilder: (_, index) => (index ==
                                                    comments.length)
                                                ? SizedBox(height: 100.h)
                                                : CommentCard(
                                                    comment: comments[index]),
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 20.h),
                                            itemCount: comments.length + 1,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 414.w,
                          height: 90.h,
                          color: paleBlue,
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 380.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: appBlue,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "Give Comment",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

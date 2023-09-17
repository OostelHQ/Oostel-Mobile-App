import 'dart:developer';

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

class _HostelInformationPageState extends State<HostelInformationPage> {
  late ScrollController scrollController;

  late List<Comment> comments;
  bool isCollapsed = false;

  @override
  void initState() {
    super.initState();

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

    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() =>
              isCollapsed = scrollController.hasClients &&
                  scrollController.offset > 450.h));
          return true;
        },
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) => [
              SliverAppBar(
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isCollapsed ? 1 : 0,
                  child: Text(
                    widget.info.name,
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600, color: weirdBlack),
                  ),
                ),
                leading: isCollapsed
                    ? IconButton(
                        onPressed: () => context.router.pop(),
                        iconSize: 26.r,
                        splashRadius: 20.r,
                        icon: const Icon(Icons.chevron_left_rounded),
                      )
                    : null,
                automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 0.0,
                expandedHeight: 470.h,
                pinned: true,
                collapsedHeight: kToolbarHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag:
                            "Hostel ID: ${widget.info.id} Image: ${widget.info.image}",
                        flightShuttleBuilder: flightShuttleBuilder,
                        child: Image.asset(
                          widget.info.image,
                          width: 414.w,
                          height: 470.h,
                          fit: BoxFit.cover,
                        ),
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
                            child: Hero(
                              tag: "Hostel ID: ${widget.info.id} Liked",
                              flightShuttleBuilder: flightShuttleBuilder,
                              child: Icon(Icons.favorite_rounded,
                                  color: Colors.red, size: 26.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 15.h),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 280.w,
                            child: Hero(
                              tag:
                                  "Hostel ID: ${widget.info.id} Name: ${widget.info.name}",
                              flightShuttleBuilder: flightShuttleBuilder,
                              child: Text(
                                widget.info.name,
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack),
                              ),
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
                                fontWeight: FontWeight.w500,
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
                            color: weirdBlack75, fontWeight: FontWeight.w500),
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
                            color: weirdBlack50,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "${widget.info.bedrooms}",
                            style: context.textTheme.bodySmall!
                                .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
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
                            style: context.textTheme.bodySmall!
                                .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 10.w),
                          SvgPicture.asset(
                            "assets/images/Hostel Info Area.svg",
                            width: 15.r,
                            height: 15.r,
                            color: weirdBlack20,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "${widget.info.area.toStringAsFixed(0)} sqft",
                            style: context.textTheme.bodySmall!
                                .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
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
                                  text: "${currency()} ${formatAmountInDouble(widget.info.price)}",
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
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: TabHeaderDelegate(
                  tabBar: TabBar(
                    indicatorColor: appBlue,
                    labelColor: appBlue,
                    labelStyle: context.textTheme.bodyMedium!
                        .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: context.textTheme.bodyMedium!
                        .copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500),
                    tabs: const [
                      Tab(text: "Landlord"),
                      Tab(text: "Details"),
                      Tab(text: "Comments")
                    ],
                  ),
                ),
                pinned: true,
              )
            ],
            controller: scrollController,
            body: TabBarView(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(height: 30.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(widget.info.owner.image),
                                    radius: 32.r,
                                  ),
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                    height: 85.h,
                                    width: 280.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      BorderRadius.circular(
                                                          12.5.h),
                                                ),
                                                child: Text(
                                                  "Verified",
                                                  style: context
                                                      .textTheme.bodyMedium!
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
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: weirdBlack75,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 110.w,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RatingStars(
                                                    value: widget
                                                        .info.owner.ratings,
                                                    starBuilder: (_, color) =>
                                                        Icon(
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
                                                        .copyWith(
                                                            color:
                                                                weirdBlack50),
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
                                                  color: weirdBlack20,
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  widget.info.owner.address,
                                                  style: context
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: weirdBlack50,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Registered since ${widget.info.owner.dateJoined.year}",
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                      color: weirdBlack50,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 50.h),
                            ],
                          ),
                        )),
                    SliverToBoxAdapter(
                      child: Container(
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
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h),
                            Text(
                              "Description",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              widget.info.description,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Rules & Regulations",
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: weirdBlack,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                widget.info.rules.length,
                                (index) => Text(
                                  "${index + 1}. ${widget.info.rules[index]}",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            Text(
                              "Available Rooms",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.r,
                          mainAxisSpacing: 15.r,
                          mainAxisExtent: 205.h,
                        ),
                        itemCount: widget.info.roomsLeft.length,
                        itemBuilder: (_, index) => AvailableRoomCard(
                            info: widget.info.roomsLeft[index]),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            Text(
                              "Hostel Facilities",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5.r,
                        mainAxisSpacing: 5.r,
                      ),
                      itemCount: widget.info.hostelFacilities.length,
                      itemBuilder: (_, index) => FacilityContainer(
                        text: widget.info.hostelFacilities[index],
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            Text(
                              "Gallery",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.r,
                            mainAxisSpacing: 10.r,
                            mainAxisExtent: 110.r),
                        itemCount: widget.info.media.length,
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
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            const RatingsOverview(),
                            SizedBox(height: 24.h),
                            Text(
                              "Comments from students",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => Column(
                            children: [
                              CommentCard(comment: comments[index]),
                              SizedBox(height: 20.h)
                            ],
                          ),
                          childCount: comments.length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          Container(
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
                          SizedBox(height: 48.h),
                          const Copyright(),
                          SizedBox(height: 24.h)
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/components/comment.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/other/gallery.dart';

class HostelInformationPage extends ConsumerStatefulWidget {
  final HostelInfo info;

  const HostelInformationPage({super.key, required this.info});

  @override
  ConsumerState<HostelInformationPage> createState() =>
      _HostelInformationPageState();
}

class _HostelInformationPageState extends ConsumerState<HostelInformationPage>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;

  final List<double> priceRanges = [0.0, 0.0];

  bool fetching = false;
  bool isCollapsed = false;
  int tabIndex = 0;

  Landowner? owner;

  late int bathroom, bedrooms;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => setState(() => tabIndex = tabController.index));
    });

    fetching = true;
    getDetails();
  }

  void calculateProps() {
    List<int> props = calculate(widget.info.rooms);
    bathroom = props[0];
    bedrooms = widget.info.rooms.length;
  }

  void getDetails() {
    getHostel(widget.info.id).then((resp) {
      if (!resp.success) {
        setState(() => fetching = false);
        showError(resp.message);
        return;
      }

      widget.info.rooms.clear();
      widget.info.rooms.addAll(resp.payload!['rooms']);

      calculateProps();
      List<double> prices = widget.info.priceRange;
      priceRanges.clear();
      priceRanges.addAll(prices);

      owner = resp.payload!["owner"];

      setState(() => fetching = false);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  String get hostelPrice {
    if(priceRanges[0] == priceRanges[1]) {
      return "${currency()} ${formatAmountInDouble(priceRanges[0])}";
    }
    return "${currency()} ${formatAmountInDouble(priceRanges[0])} - ${formatAmountInDouble(priceRanges[1])}";
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: fetching
          ? const Center(child: blueLoader)
          : (!fetching && owner == null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/Error.svg"),
                      SizedBox(height: 20.h),
                      Text(
                        "An error occurred. Please try again",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => setState(
                        () {
                          if (tabIndex == 0 &&
                              scrollController.offset > 250.h) {
                            scrollController.jumpTo(250.h);
                          }
                          isCollapsed = scrollController.hasClients &&
                              scrollController.offset > 450.h;
                        },
                      ),
                    );

                    return true;
                  },
                  child: NestedScrollView(
                    headerSliverBuilder: (context, isScrolled) => [
                      SliverAppBar(
                        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                                tag: "Hostel ID: ${widget.info.id} image",
                                flightShuttleBuilder: flightShuttleBuilder,
                                child: CachedNetworkImage(
                                  imageUrl: widget.info.media.first,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 414.w,
                                    height: 470.h,
                                    color: weirdBlack50,
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, download) => Container(
                                    width: 414.w,
                                    height: 470.h,
                                    color: weirdBlack50,
                                    alignment: Alignment.center,
                                    child: loader,
                                  ),
                                  imageBuilder: (context, provider) =>
                                      Container(
                                    width: 414.w,
                                    height: 470.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: provider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
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
                                  onTap: () {
                                    String id =
                                        ref.read(currentUserProvider).id;
                                    // if (widget.info.likes.contains(id)) {
                                    //   widget.info.likes.remove(id);
                                    // } else {
                                    //   widget.info.likes.add(id);
                                    // }
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 40.r,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Hero(
                                      tag: "Hostel ID: ${widget.info.id} Liked",
                                      flightShuttleBuilder:
                                          flightShuttleBuilder,
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        // color: widget.info.likes.contains(ref
                                        //         .read(currentUserProvider)
                                        //         .id)
                                        //     ? Colors.red
                                        //     : Colors.white,
                                        size: 26.r,
                                      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 280.w,
                                    child: Hero(
                                      tag:
                                          "Hostel ID: ${widget.info.id} Name: ${widget.info.name}",
                                      flightShuttleBuilder:
                                          flightShuttleBuilder,
                                      child: Text(
                                        widget.info.name,
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: weirdBlack,
                                        ),
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
                                      "${widget.info.rooms.length}/${widget.info.totalRooms} room${widget.info.totalRooms == 1 ? "" : "s"} left",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
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
                                joinToAddress(widget.info.address),
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500),
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
                                    "$bedrooms",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            color: weirdBlack50,
                                            fontWeight: FontWeight.w500),
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
                                    "$bathroom",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            color: weirdBlack50,
                                            fontWeight: FontWeight.w500),
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
                                        .copyWith(
                                            color: weirdBlack50,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: hostelPrice,
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                            color: appBlue,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "/year",
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
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
                          color: const Color(0xFFFBFDFF),
                          tabBar: TabBar(
                            indicatorColor: appBlue,
                            labelColor: appBlue,
                            labelStyle: context.textTheme.bodyMedium!.copyWith(
                                color: appBlue, fontWeight: FontWeight.w500),
                            unselectedLabelStyle: context.textTheme.bodyMedium!
                                .copyWith(
                                    color: weirdBlack50,
                                    fontWeight: FontWeight.w500),
                            controller: tabController,
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
                      controller: tabController,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 30.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: owner!.image,
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                        backgroundColor: weirdBlack20,
                                        radius: 32.r,
                                        child: Center(
                                          child: Icon(
                                            Icons.person_outline_rounded,
                                            color: appBlue,
                                            size: 24.r,
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, download) {
                                        return CircleAvatar(
                                          radius: 32.r,
                                          backgroundColor: weirdBlack50,
                                        );
                                      },
                                      imageBuilder: (context, provider) {
                                        return GestureDetector(
                                          onTap: () => context.router.pushNamed(
                                            Pages.viewMedia,
                                            extra: ViewInfo(
                                              current: 0,
                                              type: DisplayType.network,
                                              paths: [owner!.image],
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: provider,
                                            radius: 32.r,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      height: 85.h,
                                      width: 300.w,
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
                                                  owner!.mergedNames,
                                                  style: context
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: weirdBlack),
                                                ),
                                              ),
                                              if (owner!.verified)
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
                                                owner!.contact,
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
                                                      value: owner!.ratings,
                                                      starBuilder: (_, color) =>
                                                          Icon(
                                                        Boxicons.bxs_star,
                                                        color: color,
                                                        size: 14.r,
                                                      ),
                                                      valueLabelVisibility:
                                                          false,
                                                      starCount: 4,
                                                      starSize: 14.r,
                                                      starSpacing: 5.w,
                                                      starColor: Colors.orange,
                                                    ),
                                                    Text(
                                                      "(${owner!.totalRated})",
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
                                                  SizedBox(
                                                    width: 140.w,
                                                    child: Text(
                                                      owner!.address,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: context
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                        color: weirdBlack50,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Registered since ${owner!.dateJoined.year}",
                                                style: context
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  color: weirdBlack50,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
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
                        _RoomSection(info: widget.info),
                        const _CommentSection(),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: fetching
          ? null
          : tabIndex != 1
              ? Container(
                  width: 414.w,
                  height: 90.h,
                  color: paleBlue,
                  child: (!fetching && owner == null)
                      ? Row(
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
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
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
                                setState(() => fetching = true);
                                getDetails();
                              },
                              child: Container(
                                width: 170.w,
                                height: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: appBlue,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Retry",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Icon(Boxicons.bx_redo,
                                        color: Colors.white, size: 26.r),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : tabIndex == 2
                          ? Container(
                              width: 414.w,
                              height: 90.h,
                              color: paleBlue,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (_) => const _WriteComment(),
                                  isScrollControlled: true,
                                ),
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
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 170.w,
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                          color: appBlue, width: 1.5),
                                    ),
                                    child: Text(
                                      "Start a chat",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: appBlue),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                    context: context,
                                    isDismissible: true,
                                    builder: (_) =>
                                        HostelInfoModal(info: widget.info),
                                  ),
                                  child: Container(
                                    width: 170.w,
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: appBlue,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      "Pay",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                )
              : null,
    );
  }
}

class _CommentSection extends StatefulWidget {
  const _CommentSection();

  @override
  State<_CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<_CommentSection> {
  late List<Comment> comments;

  @override
  void initState() {
    super.initState();
    comments = [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
        comments.isEmpty
            ? SliverFillRemaining(
                child: SizedBox(
                  height: 450.r,
                  width: 414.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.r),
                      Image.asset(
                        "assets/images/No Data.png",
                        width: 150.r,
                        height: 150.r,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 50.r),
                      Text(
                        "There are no comments from the students yet.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverList.separated(
                  itemBuilder: (_, index) => CommentCard(
                    comment: comments[index],
                    isStudentSection: true,
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: comments.length,
                ),
              ),
      ],
    );
  }
}

class _RoomSection extends StatelessWidget {
  final HostelInfo info;

  const _RoomSection({
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                SizedBox(height: 8.h),
                Text(
                  info.description,
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
                    info.rules.length,
                    (index) => Text(
                      "${index + 1}. ${info.rules[index]}",
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
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
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
              mainAxisExtent: 215.h,
            ),
            itemCount: info.rooms.length,
            itemBuilder: (_, index) => AvailableRoomCard(
              info: info.rooms[index],
              fromStudent: true,
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
                  "Hostel Facilities",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5.r,
              mainAxisSpacing: 15.r,
              mainAxisExtent: 105.r,
            ),
            itemCount: info.hostelFacilities.length,
            itemBuilder: (_, index) => FacilityContainer(
              text: info.hostelFacilities[index],
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
                  "Map",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  child: Image.asset(
                    "assets/images/Map.png",
                    width: 414.w,
                    height: 170.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Gallery",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
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
                mainAxisExtent: 110.r,
            ),
            itemCount: info.media.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () => context.router.pushNamed(
                Pages.viewMedia,
                extra: ViewInfo(
                  type: DisplayType.network,
                  paths: info.media,
                  current: index,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: info.media[index],
                errorWidget: (context, url, error) => Container(
                  width: 110.r,
                  height: 110.r,
                  color: weirdBlack50,
                ),
                progressIndicatorBuilder: (context, url, download) => Container(
                  width: 110.r,
                  height: 110.r,
                  color: weirdBlack50,
                  alignment: Alignment.center,
                  child: loader,
                ),
                imageBuilder: (context, provider) => Container(
                  width: 110.r,
                  height: 110.r,
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
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 48.h),
            ],
          ),
        )
      ],
    );
  }
}

class _WriteComment extends StatefulWidget {
  const _WriteComment();

  @override
  State<_WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<_WriteComment> {
  final TextEditingController controller = TextEditingController();

  int index = 0;
  double starValue = 0.0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 400.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    SvgPicture.asset("assets/images/Modal Line.svg"),
                    SizedBox(height: 25.h),
                    if (index == 2)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: Image.asset(
                            "assets/images/Thank You.png",
                            width: 135.r,
                            height: 135.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (index == 2) SizedBox(height: 16.h),
                    Text(
                      index == 0
                          ? "Write a comment"
                          : index == 1
                              ? "Please rate the hostel"
                              : "Thanks for helping others",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      index == 0
                          ? "Writing a comment helps your colleagues to vividly understand the status of this hostel."
                          : index == 1
                              ? "Rating this hostel help your colleagues to know more about this hostel before they can be considered to pay the hostel rent."
                              : "Your feedback have made it easy for others to know the status of the hostel.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    if (index == 0)
                      SpecialForm(
                        controller: controller,
                        width: 390.w,
                        height: 100.h,
                        maxLines: 6,
                        onChange: (val) => textChecker(
                          text: val,
                          onAction: () => setState(() {}),
                        ),
                      ),
                    if (index == 1)
                      RatingStars(
                        value: starValue,
                        starBuilder: (_, color) => Icon(
                          Boxicons.bxs_star,
                          color: color,
                          size: 40.r,
                        ),
                        onValueChanged: (value) =>
                            setState(() => starValue = value),
                        valueLabelVisibility: false,
                        starCount: 5,
                        starSize: 40.r,
                        starSpacing: 20.w,
                        starColor: accentYellowColor,
                        starOffColor: weirdBlack.withOpacity(0.1),
                      ),
                    SizedBox(height: index == 2 ? 0.h : 60.h),
                    GestureDetector(
                      onTap: () {
                        if (index == 2) {
                          Navigator.of(context).pop();
                          return;
                        }

                        if (controller.text.isEmpty) return;
                        setState(() => ++index);
                      },
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.text.isEmpty
                              ? appBlue.withOpacity(0.4)
                              : appBlue,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          "Submit",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (index == 2) SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

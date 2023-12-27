import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/comment.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/other/gallery.dart';

class LandlordHostelInformationPage extends ConsumerStatefulWidget {
  final HostelInfo info;

  const LandlordHostelInformationPage({super.key, required this.info});

  @override
  ConsumerState<LandlordHostelInformationPage> createState() =>
      _LandlordHostelInformationPageState();
}

class _LandlordHostelInformationPageState
    extends ConsumerState<LandlordHostelInformationPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  bool isCollapsed = false;
  int tabIndex = 0;

  late int bathroom, bedrooms;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => setState(() => tabIndex = tabController.index));
    });

    List<int> props = calculate(widget.info.rooms);
    bathroom = props[0];
    bedrooms = widget.info.rooms.length;
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => setState(
              () {
                if ((tabIndex == 0 || tabIndex == 5) &&
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
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
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
                          "Hostel ID: ${widget.info.id} Image: ${widget.info.media.first}",
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: CachedNetworkImage(
                        imageUrl: widget.info.media.first,
                        errorWidget: (context, url, error) => Container(
                          width: 414.w,
                          height: 470.h,
                          color: weirdBlack50,
                          alignment: Alignment.center,
                          child: loader,
                        ),
                        progressIndicatorBuilder: (context, url, download) =>
                            Container(
                          width: 414.w,
                          height: 470.h,
                          color: weirdBlack50,
                        ),
                        imageBuilder: (context, provider) => Container(
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
                      child: PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          PopupMenuItem<String>(
                            value: "Edit hostel details",
                            child: Text(
                              "Edit hostel details",
                              style: context.textTheme.bodyMedium,
                            ),
                          )
                        ],
                        onSelected: (result) => context.router.pushNamed(
                          Pages.editStepOne,
                          extra: widget.info.data,
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
                      joinToAddress(widget.info.address),
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
                          "$bedrooms",
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
                          "$bathroom",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
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
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
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
                                text:
                                    "${currency()} ${formatAmountInDouble(widget.info.price)}",
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
                color: const Color(0xFFFBFDFF),
                tabBar: TabBar(
                  indicatorColor: appBlue,
                  controller: tabController,
                  labelColor: appBlue,
                  labelStyle: context.textTheme.bodyMedium!
                      .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50, fontWeight: FontWeight.w500),
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "Analytics"),
                    Tab(text: "About"),
                    Tab(text: "Chats"),
                    Tab(text: "Rooms"),
                    Tab(text: "Comments"),
                    Tab(text: "Calender")
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
              Center(
                child: Text(
                  "Coming Soon...",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _AboutSection(info: widget.info),
              Center(
                child: Text(
                  "Coming Soon...",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _RoomSection(info: widget.info),
              const _CommentSection(),
              Center(
                child: Text(
                  "Coming Soon...",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AboutSection extends StatelessWidget {
  final HostelInfo info;

  const _AboutSection({
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
          child: SizedBox(height: 50.h),
        )
      ],
    );
  }
}

class _RoomSection extends StatefulWidget {
  final HostelInfo info;

  const _RoomSection({
    required this.info,
  });

  @override
  State<_RoomSection> createState() => _RoomSectionState();
}

class _RoomSectionState extends State<_RoomSection> {
  final TextEditingController roomSearch = TextEditingController();
  final List<RoomInfo> filteredRooms = [];

  int? showRoomIndex;

  List<RoomInfo> get rentedRooms {
    List<RoomInfo> rooms = [];
    for (RoomInfo info in widget.info.rooms) {
      if (!widget.info.roomsLeft.contains(info.id)) {
        rooms.add(info);
      }
    }
    return rooms;
  }

  @override
  void dispose() {
    roomSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<RoomInfo> rented = rentedRooms;

    return CustomScrollView(
      slivers: showRoomIndex == null
          ? [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      SpecialForm(
                        controller: roomSearch,
                        height: 50.h,
                        width: 414.w,
                        hint: "Search room...",
                        prefix: const Icon(Icons.search_rounded,
                            color: weirdBlack25),
                        borderColor: Colors.transparent,
                        fillColor: Colors.white,
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
                        onChange: (val) => setState(
                          () {
                            filteredRooms.clear();
                            if (val.trim().isNotEmpty) {
                              for (RoomInfo info in widget.info.rooms) {
                                if (info.name
                                    .toLowerCase()
                                    .contains(val.trim().toLowerCase())) {
                                  filteredRooms.add(info);
                                }
                              }

                              if (filteredRooms.isEmpty) {
                                filteredRooms.add(noRoom);
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),
                      if (filteredRooms.isEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Vacant Rooms",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "${widget.info.roomsLeft.length} rooms",
                              style: context.textTheme.bodySmall!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      if (filteredRooms.isEmpty) SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
              if (filteredRooms.isEmpty)
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
                      info: widget.info.roomAt(index),
                      available: true,
                      onTap: () => setState(
                          () => showRoomIndex = widget.info.indexAt(index)),
                    ),
                  ),
                ),
              if (filteredRooms.isEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rented Rooms",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "${rented.length} rooms",
                              style: context.textTheme.bodySmall!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              if (filteredRooms.isEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.r,
                      mainAxisSpacing: 15.r,
                      mainAxisExtent: 215.h,
                    ),
                    itemCount: rented.length,
                    itemBuilder: (_, index) => AvailableRoomCard(
                      info: rented[index],
                      onTap: () => setState(
                          () => showRoomIndex = widget.info.indexAt(index)),
                    ),
                  ),
                ),
              if (filteredRooms.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: filteredRooms.first == noRoom
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text(
                              "No room matches your search!",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.r,
                            mainAxisSpacing: 15.r,
                            mainAxisExtent: 205.h,
                          ),
                          itemCount: filteredRooms.length,
                          itemBuilder: (_, index) => AvailableRoomCard(
                            info: filteredRooms[index],
                            available:
                                widget.info.isAvailable(filteredRooms[index]),
                            onTap: () => setState(() =>
                                showRoomIndex = widget.info.indexAt(index)),
                          ),
                        ),
                ),
              SliverToBoxAdapter(
                child: SizedBox(height: 50.h),
              )
            ]
          : [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => showRoomIndex = null),
                            child: Icon(Icons.chevron_left_rounded, size: 26.r),
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            widget.info.isAvailableIndex(showRoomIndex!)
                                ? "Vacant Room"
                                : "Rented Room",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600, color: weirdBlack),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      _ShowRoomCard(
                        room: widget.info.rooms[showRoomIndex!],
                        isAvailable:
                            widget.info.isAvailableIndex(showRoomIndex!),
                      )
                    ],
                  ),
                ),
              ),
            ],
    );
  }
}

class _ShowRoomCard extends StatelessWidget {
  final RoomInfo room;
  final bool isAvailable;
  final int? daysLeft;

  const _ShowRoomCard({
    this.daysLeft = 10,
    required this.room,
    required this.isAvailable,
  });

  void showActivationProcess(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => SizedBox(
          height: 450.h,
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
                      SizedBox(height: 55.h),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: Image.asset(
                            "assets/images/Questions.png",
                            width: 135.r,
                            height: 135.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        isAvailable
                            ? "Have you gotten a tenant?"
                            : "Has your tenant left the room?",
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: weirdBlack,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        isAvailable
                            ? "Considering deactivating a room due to tenant occupancy. Confirm your decision, and make your property listing accurate."
                            : "Is your tenant vacating a room, and you'd like to reactivate it? Confirm to make your room available for new tenants.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 180.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: appBlue),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "No, cancel",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: appBlue,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 180.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: appBlue,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "Yes, proceed",
                                style: context.textTheme.bodyMedium!.copyWith(
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
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E5EC),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: room.media.first,
                errorWidget: (context, url, error) => Container(
                  width: 414.w,
                  height: 170.h,
                  color: weirdBlack50,
                  alignment: Alignment.center,
                  child: loader,
                ),
                progressIndicatorBuilder: (context, url, download) => Container(
                  width: 414.w,
                  height: 170.h,
                  color: weirdBlack50,
                ),
                imageBuilder: (context, provider) => Container(
                  width: 414.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (isAvailable)
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
          SizedBox(height: 8.h),
          SizedBox(
            height: 45.r,
            child: ListView.separated(
              itemBuilder: (_, index) => CachedNetworkImage(
                imageUrl: room.media[index],
                errorWidget: (context, url, error) => Container(
                  width: 60.r,
                  height: 45.r,
                  color: weirdBlack50,
                ),
                progressIndicatorBuilder: (context, url, download) => Container(
                  width: 60.r,
                  height: 45.r,
                  color: weirdBlack50,
                ),
                imageBuilder: (context, provider) => Container(
                  width: 60.r,
                  height: 45.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemCount: room.media.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            room.name,
            style: context.textTheme.bodyLarge!
                .copyWith(color: weirdBlack, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Text(
            "This room is currently open for student to rent and get you paid.",
            style: context.textTheme.bodyMedium!
                .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${currency()} ${formatAmountInDouble(room.price)}",
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
            "Room Facilities",
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: weirdBlack,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 120.r,
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(width: 20.w),
              scrollDirection: Axis.horizontal,
              itemCount: room.facilities.length,
              itemBuilder: (_, index) => FacilityContainer(
                text: room.facilities[index],
              ),
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () => context.router.pushNamed(Pages.editRoom, extra: room),
            child: Container(
              width: 414.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: appBlue),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/Blue Edit.svg"),
                  SizedBox(width: 10.w),
                  Text(
                    "Edit",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: appBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
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
    Student student = Student(
      firstName: "Elizabeth",
      lastName: "Enitan",
      image: "assets/images/watch man.jpg",
      dateJoined: DateTime.now(),
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
                    isStudentSection: false,
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: comments.length,
                ),
              ),
      ],
    );
  }
}

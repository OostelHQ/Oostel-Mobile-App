import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/receipt_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);
    List<Receipt> receipts = ref.watch(receiptsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                iconSize: 26.r,
                splashRadius: 0.01,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => context.router.pop(),
              ),
              elevation: 0.0,
              pinned: true,
              centerTitle: true,
              title: Text(
                "Profile",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                    child: Stack(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 100.h,
                            minWidth: 414.w,
                            maxHeight: 100.h,
                            maxWidth: 414.w,
                          ),
                          child: const ColoredBox(
                            color: paleBlue,
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          bottom: 10.r,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 48.r,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(student.image),
                              radius: 45.r,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20.w,
                          bottom: 30.r,
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/images/Edit.svg",
                              width: 20.r,
                              height: 20.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.mergedNames,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      student.email,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Roomate Info Location.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Nigeria",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 15.w),
                        SvgPicture.asset(
                          "assets/images/Calender.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Joined ${formatDateRaw(student.joined)}",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "${student.rentedHostels < 10 ? "0" : ""}${student.rentedHostels}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack75,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                text: " Rented Hostels",
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "${student.collaboratedRoommates < 10 ? "0" : ""}${student.collaboratedRoommates}",
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: " Collaborate Roommates",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: weirdBlack50,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => const _RoommateActivation(),
                          ),
                          child: Container(
                            width: 180.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: appBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Text(
                              student.available ? "Open to" : "Disable",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
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
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: appBlue, width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share_rounded,
                                  color: appBlue,
                                  size: 20.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Share",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: appBlue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 414.w,
                        minHeight: 1.h,
                        maxWidth: 414.w,
                        maxHeight: 1.h,
                      ),
                      child: const ColoredBox(color: Colors.black12),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Analytics",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "Private to you",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Blue Eye.svg",
                      header: "${student.profileViews} profile views",
                      text: "Fellow colleagues viewed your profile",
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Search Appearance.svg",
                      header: "${student.searchAppearances} search appearances",
                      text: "How often you appear in search results",
                    ),
                    SizedBox(height: 28.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 414.w,
                        minHeight: 1.h,
                        maxWidth: 414.w,
                        maxHeight: 1.h,
                      ),
                      child: const ColoredBox(color: Colors.black12),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "About",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "Public to fellow students",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    BasicStudentInfo(student: student),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 414.w,
                        minHeight: 1.h,
                        maxWidth: 414.w,
                        maxHeight: 1.h,
                      ),
                      child: const ColoredBox(color: Colors.black12),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Receipts",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "Private to you",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => ReceiptContainer(receipt: receipts[index]),
                  childCount: receipts.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 48.h),
                  const Center(child: Copyright()),
                  SizedBox(height: 24.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RoommateActivation extends ConsumerStatefulWidget {
  const _RoommateActivation({super.key});

  @override
  ConsumerState<_RoommateActivation> createState() =>
      _RoommateActivationState();
}

class _RoommateActivationState extends ConsumerState<_RoommateActivation> {
  final TextEditingController amount = TextEditingController();

  String? gottenHostel;
  int? selectedLocation;

  bool activated = false;


  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> locations = ref.watch(locationProvider);

    return SizedBox(
      height: 450.h,
      width: 414.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: CustomScrollView(
          slivers: [
            !activated ?
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                      child: SvgPicture.asset("assets/images/Modal Line.svg")),
                  SizedBox(height: 25.h),
                  Center(
                    child: Text(
                      "Activate Availability for Partnering",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      "Writing a comment helps your colleague to vividly understand the status of this hostel.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Have you gotten a hostel?",
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  ComboBox(
                    hint: "Yes/No",
                    value: gottenHostel,
                    dropdownItems: const ["Yes", "No"],
                    onChanged: (val) => setState(() => gottenHostel = val),
                    icon: const Icon(Boxicons.bxs_down_arrow_alt),
                    buttonWidth: 240.w,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel Address",
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 12.w,
                    children: List.generate(
                      locations.length,
                      (index) => GestureDetector(
                        onTap: () => setState(() => selectedLocation = index),
                        child: Container(
                          height: 40.h,
                          width: 105.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedLocation != null &&
                                      selectedLocation == index
                                  ? appBlue
                                  : fadedBorder,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                            color: selectedLocation != null &&
                                    selectedLocation == index
                                ? paleBlue
                                : null,
                          ),
                          child: Text(
                            locations[index],
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: selectedLocation != null &&
                                      selectedLocation == index
                                  ? appBlue
                                  : weirdBlack50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Amount",
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  SpecialForm(
                    controller: amount,
                    width: 414.w,
                    height: 50.h,
                    hint: "00.00",
                    type: TextInputType.number,
                  ),
                  SizedBox(height: 40.h),
                  Row(
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
                            border: Border.all(color: appBlue, width: 1.5),
                          ),
                          child: Text(
                            "Cancel",
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: appBlue),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => activated = true),
                        child: Container(
                          width: 180.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appBlue,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            "Available",
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ) : SliverToBoxAdapter(
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
                      child: SvgPicture.asset(
                        "assets/images/Some Image.svg",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Activated Successfully",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "You're now open to collaborate with other students as your roommate",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 42.h),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
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

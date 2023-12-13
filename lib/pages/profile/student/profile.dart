import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/receipt_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/pages/other/gallery.dart';

class StudentProfilePage extends ConsumerStatefulWidget {
  const StudentProfilePage({super.key});

  @override
  ConsumerState<StudentProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<StudentProfilePage> {
  bool loading = true;
  bool? isAvailable;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() {
    getStudentById(ref.read(currentUserProvider).id).then((resp) {
      if (!mounted) return;
      setState(() {
        isAvailable = resp.payload!["studentProfile"]["isAvailable"];
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(currentUserProvider) as Student;
    int acquiredHostels = ref.watch(acquiredHostelsProvider).length;
    int acquiredRoommates = ref.watch(acquiredRoommatesProvider).length;

    return Scaffold(
      body: SafeArea(
        child: loading
            ? const Center(child: blueLoader)
            : !loading && isAvailable == null
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
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
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
                                    child: Container(
                                      width: 100.r,
                                      height: 100.r,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFE0E5EC),
                                            blurRadius: 1.0,
                                            spreadRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: student.image == ""
                                          ? CircleAvatar(
                                              radius: 47.5.r,
                                              backgroundColor: appBlue,
                                              child: Center(
                                                child: Text(
                                                  student.firstName
                                                      .substring(0, 1),
                                                  style: context
                                                      .textTheme.displaySmall!
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: student.image,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                backgroundColor: weirdBlack20,
                                                radius: 47.5.r,
                                                child: Center(
                                                  child: Icon(
                                                    Icons
                                                        .person_outline_rounded,
                                                    color: appBlue,
                                                    size: 42.r,
                                                  ),
                                                ),
                                              ),
                                              progressIndicatorBuilder:
                                                  (context, url, download) {
                                                return CircleAvatar(
                                                  radius: 47.5.r,
                                                  backgroundColor: weirdBlack50,
                                                );
                                              },
                                              imageBuilder:
                                                  (context, provider) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      context.router.pushNamed(
                                                    Pages.viewMedia,
                                                    extra: ViewInfo(
                                                      current: 0,
                                                      type: DisplayType.network,
                                                      paths: [student.image],
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundImage: provider,
                                                    radius: 47.5.r,
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 20.w,
                                    bottom: 30.r,
                                    child: GestureDetector(
                                      onTap: () => context.router
                                          .pushNamed(Pages.editProfile),
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
                                style: context.textTheme.bodyMedium!.copyWith(
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
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: weirdBlack50,
                                            fontWeight: FontWeight.w500),
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
                                    "Joined ${formatDateRaw(student.dateJoined)}",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: weirdBlack50,
                                            fontWeight: FontWeight.w500),
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
                                              "${acquiredHostels < 10 ? "0" : ""}$acquiredHostels",
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
                                                  color: weirdBlack75,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: " Rented Hostels",
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
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
                                              "${acquiredRoommates < 10 ? "0" : ""}$acquiredRoommates",
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
                                            color: weirdBlack75,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " Collaborate Roommates",
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () => showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (_) =>
                                          const _RoommateActivation(),
                                    ),
                                    child: Container(
                                      width: 180.w,
                                      height: 50.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: appBlue,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Text(
                                        !isAvailable! ? "Open to" : "Disable",
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
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
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        border: Border.all(
                                            color: appBlue, width: 1.5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.share_rounded,
                                            color: appBlue,
                                            size: 20.r,
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "Share",
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Analytics",
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: weirdBlack),
                                  ),
                                  Text(
                                    "Private to you",
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Column(
                                children: [
                                  ProfileInfoCard(
                                    image: "assets/images/Blue Eye.svg",
                                    header:
                                        "${student.profileViews} profile views",
                                    text:
                                        "Fellow colleagues viewed your profile",
                                  ),
                                  SizedBox(height: 15.h),
                                  ProfileInfoCard(
                                    image:
                                        "assets/images/Search Appearance.svg",
                                    header:
                                        "${student.searchAppearances} search appearances",
                                    text:
                                        "How often you appear in search results",
                                  ),
                                ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "About",
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: weirdBlack),
                                  ),
                                  Text(
                                    "Public to fellow students",
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.h),
                              if (student.hasCompletedProfile > 20)
                                Column(children: [
                                  ProfileInfoCard(
                                    image: "assets/images/Profile Phone.svg",
                                    header: student.contact,
                                    text: "Phone Number",
                                  ),
                                  SizedBox(height: 15.h),
                                ]),
                              if (student.hasCompletedProfile > 20)
                                BasicStudentInfo(student: student),
                              if (student.hasCompletedProfile > 20)
                                Column(children: [
                                  SizedBox(height: 20.h),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 414.w,
                                      minHeight: 1.h,
                                      maxWidth: 414.w,
                                      maxHeight: 1.h,
                                    ),
                                    child:
                                        const ColoredBox(color: Colors.black12),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "About",
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: weirdBlack),
                                      ),
                                      Text(
                                        "Private to you",
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          color: weirdBlack50,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  ProfileInfoCard(
                                    image: "assets/images/Profile Phone.svg",
                                    header: student.guardian,
                                    text: "Guardians Phone Number",
                                  ),
                                ]),
                              if (student.hasCompletedProfile <= 20)
                                SizedBox(
                                  height: 450.r,
                                  width: 414.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 50.r),
                                      Image.asset(
                                        "assets/images/No Data.png",
                                        width: 150.r,
                                        height: 150.r,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 50.r),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Unlock the full experience! Your profile details are empty. ",
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                color: weirdBlack75,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Complete my profile",
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: appBlue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => context.router
                                                    .pushNamed(
                                                        Pages.editProfile),
                                            )
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 50.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: !loading && isAvailable == null
          ? Container(
              width: 414.w,
              height: 90.h,
              color: paleBlue,
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
                      setState(() => loading = true);
                      fetch();
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
                            style: context.textTheme.bodyMedium!.copyWith(
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
              ))
          : null,
    );
  }
}

class _RoommateActivation extends ConsumerStatefulWidget {
  const _RoommateActivation();

  @override
  ConsumerState<_RoommateActivation> createState() =>
      _RoommateActivationState();
}

class _RoommateActivationState extends ConsumerState<_RoommateActivation> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController address = TextEditingController();

  String? gottenHostel;

  bool activated = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  late Map<String, dynamic> authDetails;

  @override
  void initState() {
    super.initState();
    authDetails = {
      "studentId": ref.read(currentUserProvider),
      "hostelName": "",
      "hostelPrice": 0,
      "hostelAddress": ""
    };
  }

  @override
  void dispose() {
    address.dispose();
    amount.dispose();
    super.dispose();
  }

  bool get isFilled {
    if (gottenHostel == null) return false;
    if (gottenHostel == "Yes") {
      return address.text.trim().isNotEmpty && amount.text.trim().isNotEmpty;
    } else {
      return amount.text.isNotEmpty;
    }
  }

  Future<void> open() async {
    openToRoommate(authDetails).then((resp) {
      if (!mounted) return;
      if (!resp.success) {
        showError(resp.message);
        Navigator.of(context).pop();
      } else {
        setState(() => activated = true);
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: loader,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 500),
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: gottenHostel != null && gottenHostel == "Yes" ? 600.h : 450.h,
        width: 414.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: CustomScrollView(
            slivers: [
              !activated
                  ? SliverToBoxAdapter(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Center(
                                child: SvgPicture.asset(
                                    "assets/images/Modal Line.svg")),
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
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8.h),
                            ComboBox(
                              hint: "Yes/No",
                              value: gottenHostel,
                              dropdownItems: const ["Yes", "No"],
                              onChanged: (val) =>
                                  setState(() => gottenHostel = val),
                              icon: const Icon(Boxicons.bxs_down_arrow),
                              buttonWidth: 414.w,
                              dropdownWidth: 370.w,
                            ),
                            SizedBox(height: 16.h),
                            if (gottenHostel != null && gottenHostel == "Yes")
                              Text(
                                "Hostel Address",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500),
                              ),
                            if (gottenHostel != null && gottenHostel == "Yes")
                              SizedBox(height: 8.h),
                            if (gottenHostel != null && gottenHostel == "Yes")
                              SpecialForm(
                                controller: address,
                                width: 414.w,
                                height: 50.h,
                                hint: "e.g Kofesu, Camp, Harmony",
                                onSave: (val) =>
                                    setState(() => authDetails["hostelAddress"] = val!),
                                onValidate: (value) {
                                  if (value!.trim().isEmpty) {
                                    showError("Invalid Hostel Address");
                                    return '';
                                  }
                                  return null;
                                },
                                onChange: (val) => textChecker(
                                  text: val,
                                  onAction: () => setState(() {}),
                                ),
                              ),
                            SizedBox(height: 16.h),
                            Text(
                              "Amount",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8.h),
                            SpecialForm(
                              controller: amount,
                              width: 414.w,
                              height: 50.h,
                              hint: "00.00",
                              type: TextInputType.number,
                              onSave: (val) => authDetails["hostelPrice"] = double.parse(val!.trim()),
                              onValidate: (value) {
                                value = value.trim();
                                if (double.tryParse(value) == null) {
                                  showError("Invalid Amount Entered");
                                  return '';
                                }
                                return null;
                              },
                              onChange: (val) => textChecker(
                                text: val,
                                onAction: () => setState(() {}),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            GestureDetector(
                              onTap: () {
                                if (!validateForm(formKey)) return;
                                open();
                              },
                              child: Container(
                                width: 414.w,
                                height: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isFilled
                                      ? appBlue
                                      : appBlue.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Text(
                                  "Activate",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(
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
                                "assets/images/Open To.png",
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
                          SizedBox(height: 50.h),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 414.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isFilled
                                    ? appBlue
                                    : appBlue.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "Ok, Thanks",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
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

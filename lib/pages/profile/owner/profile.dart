import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/pages/other/gallery.dart';

class OwnerProfilePage extends ConsumerStatefulWidget {
  const OwnerProfilePage({super.key});

  @override
  ConsumerState<OwnerProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<OwnerProfilePage> {
  bool getProfileAnalytics = false;
  int totalRooms = 0;

  @override
  void initState() {
    super.initState();
    getProfileAnalytics = true;
    getAnalytics();
    List<HostelInfo> allHostels = ref.read(ownerHostelsProvider);
    for (HostelInfo info in allHostels) {
      totalRooms += info.rooms.length;
    }
  }

  void getAnalytics() {
    profileViewCounts(ref.read(currentUserProvider).id).then((resp) {
      if (!mounted) return;

      setState(() => getProfileAnalytics = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Landowner owner = ref.watch(currentUserProvider) as Landowner;
    List<HostelInfo> allHostels = ref.watch(ownerHostelsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                            child: owner.image == ""
                                ? CircleAvatar(
                                    radius: 47.5.r,
                                    backgroundColor: appBlue,
                                    child: Center(
                                      child: Text(
                                        owner.firstName.substring(0, 1),
                                        style: context.textTheme.displaySmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: owner.image,
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      backgroundColor: weirdBlack20,
                                      radius: 47.5.r,
                                      child: Center(
                                        child: Icon(
                                          Icons.person_outline_rounded,
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
                                    imageBuilder: (context, provider) {
                                      return GestureDetector(
                                        onTap: () => context.router.pushNamed(
                                          Pages.viewMedia,
                                          extra: ViewInfo(
                                            current: 0,
                                            type: DisplayType.network,
                                            paths: [owner.image],
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
                                .pushNamed(Pages.editOwnerProfile),
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
                      owner.mergedNames,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      owner.email,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      owner.contact,
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
                          style: context.textTheme.bodyMedium!.copyWith(
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
                          "Joined ${formatDateRaw(owner.dateJoined)}",
                          style: context.textTheme.bodyMedium!.copyWith(
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
                                    "${allHostels.length < 10 ? "0" : ""}${allHostels.length}",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: " Hostels",
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
                                    "${totalRooms < 10 ? "0" : ""}$totalRooms",
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: " Rooms",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: weirdBlack50,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => const AgentInvite(),
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
                              "Invite Agent",
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
                    getProfileAnalytics
                        ? const Center(child: blueLoader)
                        : Column(
                            children: [
                              ProfileInfoCard(
                                image: "assets/images/Blue Eye.svg",
                                header: "${owner.profileViews} profile views",
                                text: "Fellow colleagues viewed your profile",
                              ),
                              SizedBox(height: 15.h),
                              ProfileInfoCard(
                                image: "assets/images/Search Appearance.svg",
                                header:
                                    "${owner.searchAppearances} hostel search appearances",
                                text: "How often you appear in search results",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Info",
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
                    if (owner.hasCompletedProfile > 20)
                      Column(children: [
                        ProfileInfoCard(
                          image: "assets/images/Profile Blue Location.svg",
                          header: owner.address,
                          text: "Personal Address",
                        ),
                        SizedBox(height: 16.h),
                        ProfileInfoCard(
                          image: "assets/images/Profile Religion.svg",
                          header: owner.religion,
                          text: "Religion",
                        ),
                        if (owner.religion == "Christianity")
                          SizedBox(height: 16.h),
                        if (owner.religion == "Christianity")
                          ProfileInfoCard(
                            image: "assets/images/Profile Church.svg",
                            header: owner.denomination,
                            text: "Denomination",
                          ),
                        SizedBox(height: 16.h),
                        ProfileInfoCard(
                          image: "assets/images/Profile Age.svg",
                          header: formatDateRaw(owner.dob),
                          text: "Date of Birth",
                        ),
                      ]),
                    if (owner.hasCompletedProfile <= 20)
                      SizedBox(
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Unlock the full experience! Your profile details are empty. ",
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack75,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Complete my profile",
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: appBlue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context.router
                                          .pushNamed(Pages.editOwnerProfile),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 48.h),
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

//Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Hostel Information",
//                           style: context.textTheme.bodyLarge!.copyWith(
//                               fontWeight: FontWeight.w600, color: weirdBlack),
//                         ),
//                         Text(
//                           "Public to students",
//                           style: context.textTheme.bodyMedium!.copyWith(
//                             color: weirdBlack50,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 15.h),
//                     ProfileInfoCard(
//                       image: "assets/images/Profile Blue Location.svg",
//                       header: allHostels.first.name,
//                       text: "Hostel name",
//                     ),
//                     SizedBox(height: 16.h),
//                     ProfileInfoCard(
//                       image: "assets/images/Profile Blue Location.svg",
//                       header: allHostels.first.id,
//                       text: "Identification number",
//                     ),
//                     SizedBox(height: 16.h),
//                     ProfileInfoCard(
//                       image: "assets/images/Profile Blue Location.svg",
//                       header: joinToAddress(allHostels.first.address),
//                       text: "Address",
//                     ),
//                     SizedBox(height: 24.h),
//                     ConstrainedBox(
//                       constraints: BoxConstraints(
//                         minWidth: 414.w,
//                         minHeight: 1.h,
//                         maxWidth: 414.w,
//                         maxHeight: 1.h,
//                       ),
//                       child: const ColoredBox(color: Colors.black12),
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Face Capturing",
//                           style: context.textTheme.bodyLarge!.copyWith(
//                               fontWeight: FontWeight.w600, color: weirdBlack),
//                         ),
//                         Text(
//                           "Private to you",
//                           style: context.textTheme.bodyMedium!.copyWith(
//                             color: weirdBlack50,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 15.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF8FBFF),
//                         borderRadius: BorderRadius.circular(4.r),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0xFFE0E5EC),
//                             blurRadius: 6.0,
//                             spreadRadius: 1.0,
//                           )
//                         ],
//                       ),
//                       child: SizedBox(
//                         height: 70.h,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 10.w),
//                             Container(
//                               width: 50.r,
//                               height: 50.r,
//                               alignment: Alignment.center,
//                               decoration: const BoxDecoration(
//                                 color: paleBlue,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: SvgPicture.asset(
//                                   "assets/images/Profile Face.svg"),
//                             ),
//                             SizedBox(width: 15.w),
//                             Text(
//                               owner.verified
//                                   ? "Successfully done"
//                                   : "Not verified",
//                               style: context.textTheme.bodyLarge!.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   color: weirdBlack),
//                             ),
//                             SizedBox(width: !owner.verified ? 100.w : 60.w),
//                             if (owner.verified)
//                               Container(
//                                 width: 70.w,
//                                 height: 25.h,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: paleBlue,
//                                   borderRadius: BorderRadius.circular(12.5.h),
//                                 ),
//                                 child: Text(
//                                   "Verified",
//                                   style: context.textTheme.bodyMedium!.copyWith(
//                                     color: appBlue,
//                                     fontSize: 13.sp,
//                                   ),
//                                 ),
//                               )
//                           ],
//                         ),
//                       ),
//                     ),

class AgentInvite extends StatefulWidget {
  const AgentInvite({super.key});

  @override
  State<AgentInvite> createState() => _AgentInviteState();
}

class _AgentInviteState extends State<AgentInvite> {
  final TextEditingController email = TextEditingController(),
      note = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    note.dispose();
    super.dispose();
  }

  bool sent = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      child: SizedBox(
        height: 555.h,
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
                    SizedBox(height: sent ? 55.h : 25.h),
                    if (sent)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: Image.asset(
                            "assets/images/Agent Invite.png",
                            width: 135.r,
                            height: 135.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (sent) SizedBox(height: 16.h),
                    Text(
                      !sent ? "Invite an Agent" : "Invite Sent",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      !sent
                          ? "Invite your own co-worker to help you manage and market your hostel to the students."
                          : "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (sent) SizedBox(height: 60.h),
                    SizedBox(height: 32.h),
                    Text(
                      "Email",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8.h),
                    SpecialForm(
                      controller: email,
                      width: 414.w,
                      height: 50.h,
                      hint: "example@example.com",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Short note",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8.h),
                    SpecialForm(
                      controller: note,
                      width: 414.w,
                      height: 150.h,
                      maxLines: 6,
                      hint:
                          "Hello, \n\nI'm hereby inviting you to this platform as an Agent to manage my apartment.\n\nThanks.",
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!sent) {
                          setState(() => sent = true);
                          return;
                        }
                        context.router.pop();
                      },
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appBlue,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          !sent ? "Send Invite" : "Ok, thanks",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Note that: Your co-workers do not have access to withdraw any received payments from students and change the settings made by you.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: weirdBlack50,
                        fontWeight: FontWeight.w500,
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/agent.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/pages/other/gallery.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/agent.dart';

class AgentProfilePage extends ConsumerStatefulWidget {
  const AgentProfilePage({super.key});

  @override
  ConsumerState<AgentProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<AgentProfilePage> {
  @override
  Widget build(BuildContext context) {
    Agent agent = ref.watch(currentUserProvider) as Agent;

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
                            child: agent.image == "" ? CircleAvatar(
                              radius: 47.5.r,
                              backgroundColor: appBlue,
                              child: Center(
                                child: Text(
                                  agent.firstName.substring(0, 1),
                                  style: context.textTheme.displaySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ) : CachedNetworkImage(imageUrl: agent.image,
                              errorWidget: (context, url, error) => CircleAvatar(
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
                              progressIndicatorBuilder: (context, url, download) {
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
                                      paths: [agent.image],
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
                                .pushNamed(Pages.editAgentProfile),
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
                      agent.mergedNames,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      agent.email,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      agent.contact,
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
                          "Joined ${formatDateRaw(agent.dateJoined)}",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (_) => const _AccountSwap(),
                      ),
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appBlue,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/Invite Agent.svg"),
                            SizedBox(width: 10.w),
                            Text(
                              "Profiles",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                              size: 26,
                            )
                          ],
                        ),
                      ),
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
                      header: "${agent.profileViews} profile views",
                      text: "Fellow colleagues viewed your profile",
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Search Appearance.svg",
                      header:
                          "${agent.searchAppearances} hostel search appearances",
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
                    ProfileInfoCard(
                      image: "assets/images/Profile Blue Location.svg",
                      header: agent.address,
                      text: "Personal Address",
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Religion.svg",
                      header: agent.religion,
                      text: "Religion",
                    ),
                    if (agent.religion == "Christianity")
                      SizedBox(height: 15.h),
                    if (agent.religion == "Christianity")
                      ProfileInfoCard(
                        image: "assets/images/Profile Church.svg",
                        header: agent.denomination,
                        text: "Denomination",
                      ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Age.svg",
                      header: formatDateRaw(agent.dob),
                      text: "Date of Birth",
                    ),
                    SizedBox(height: 50.h),
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

class _AccountSwap extends StatefulWidget {
  const _AccountSwap();

  @override
  State<_AccountSwap> createState() => _AccountSwapState();
}

class _AccountSwapState extends State<_AccountSwap> {
  int step = 1;
  final TextEditingController code = TextEditingController();

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      child: SizedBox(
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
                    SizedBox(height: 25.h),
                    Text(
                      step == 1
                          ? "My Profiles"
                          : step == 2
                              ? "Add Account"
                              : "Verification",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      step == 2
                          ? "Add more accounts to your co-worker profile and increase your reach in assisting multiple landlords."
                          : step == 3
                              ? "Enter your referral code for verification to confirm your association with a landlord or property."
                              : "",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    if(step == 3)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Landlord Referral Code",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8.h),
                          SpecialForm(
                            controller: code,
                            width: 414.w,
                            height: 50.h,
                            hint: "Code",
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if(step == 3) {
                              Navigator.of(context).pop();
                              return;
                            }

                            setState(() => ++step);
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
                              step == 1 ? "Add Account" : step == 2 ? "Login to Existing Account" : "Proceed",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        if(step == 2)
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            width: 414.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: appBlue),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Text(
                              "Create New Account",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
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

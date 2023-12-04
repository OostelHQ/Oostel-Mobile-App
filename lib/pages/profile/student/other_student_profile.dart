import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/other/gallery.dart';

class OtherStudentProfilePage extends StatefulWidget {
  final Student info;

  const OtherStudentProfilePage({
    super.key,
    required this.info,
  });

  @override
  State<OtherStudentProfilePage> createState() =>
      _OtherStudentProfilePageState();
}

class _OtherStudentProfilePageState extends State<OtherStudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Roommate",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Icon(Icons.favorite_rounded, color: Colors.red, size: 26.r),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: Container(
                    width: 125.r,
                    height: 125.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFE0E5EC),
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                          )
                        ]),
                    alignment: Alignment.center,
                    child: widget.info.image == ""
                        ? CircleAvatar(
                            radius: 59.r,
                            backgroundColor: appBlue,
                            child: Center(
                              child: Text(
                                widget.info.firstName.substring(0, 1),
                                style: context.textTheme.displaySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.info.image,
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: weirdBlack20,
                              radius: 59.r,
                              child: Center(
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  color: appBlue,
                                  size: 64.r,
                                ),
                              ),
                            ),
                            progressIndicatorBuilder: (context, url, download) {
                              return CircleAvatar(
                                radius: 59.r,
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
                                    paths: [widget.info.image],
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: provider,
                                  radius: 59.r,
                                ),
                              );
                            },
                          ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.info.mergedNames,
                  style: context.textTheme.bodyLarge!.copyWith(
                      color: weirdBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      widget.info.location,
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${currency()} ${formatAmountInDouble(widget.info.amount)}",
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: appBlue,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: "/year",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: appBlue,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
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
                      "Personal Details",
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
                ProfileInfoCard(
                  image: "assets/images/Profile Phone.svg",
                  header: widget.info.contact,
                  text: "Phone Number",
                ),
                SizedBox(height: 15.h),
                ProfileInfoCard(
                  image: "assets/images/Profile Mail.svg",
                  header: widget.info.email,
                  text: "Email Address",
                ),
                SizedBox(height: 15.h),
                BasicStudentInfo(student: widget.info),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
                  border: Border.all(color: appBlue, width: 1.5),
                ),
                child: Text(
                  "Start a chat",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500, color: appBlue),
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
                  "Collaborate",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

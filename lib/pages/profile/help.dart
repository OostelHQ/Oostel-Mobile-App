import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with TickerProviderStateMixin {
  late TabController controller;
  final TextEditingController number =
      TextEditingController(text: "811 241 6080");
  final TextEditingController email =
      TextEditingController(text: "student@oostelsupport.com");
  final TextEditingController instagram = TextEditingController();
  final TextEditingController facebook = TextEditingController();
  final TextEditingController twitter = TextEditingController();

  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  late List<_FAQ> faqs;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
    for (int i = 0; i < 5; ++i) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
      );
      animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controllers[i],
            curve: Curves.easeInSine,
            reverseCurve: Curves.easeOutSine,
          ),
        ),
      );
    }

    faqs = List.generate(
      5,
      (index) => const _FAQ(
          question: "What is Oostel?",
          answer:
              "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet."),
    );
  }

  @override
  void dispose() {
    for (AnimationController controller in controllers) {
      controller.dispose();
    }
    twitter.dispose();
    instagram.dispose();
    facebook.dispose();
    number.dispose();
    email.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Help & Support",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: controller,
              indicatorColor: appBlue,
              labelColor: appBlue,
              labelStyle: context.textTheme.bodyMedium!
                  .copyWith(color: appBlue, fontWeight: FontWeight.w500),
              unselectedLabelStyle: context.textTheme.bodyMedium!
                  .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
              tabs: const [
                Tab(text: "FAQs"),
                Tab(text: "Contact Us"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        Text(
                          "Frequently Asked Questions",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (_, index) {
                              if (index == faqs.length) {
                                return SizedBox(height: 48.h);
                              }
                              return _FAQContainer(
                                controller: controllers[index],
                                animation: animations[index],
                                faq: faqs[index],
                              );
                            },
                            separatorBuilder: (_, __) => SizedBox(height: 16.h),
                            itemCount: faqs.length + 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          Text(
                            "Come say hello!",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600, color: weirdBlack),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            "Phone Number",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: number,
                            width: 414.w,
                            height: 50.h,
                            readOnly: true,
                            hint: "080 1234 5678",
                            prefix: SizedBox(
                              height: 50.h,
                              width: 30.w,
                              child: Center(
                                child: Text(
                                  "+234",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack75,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            suffix: GestureDetector(
                              onTap: () =>
                                  FlutterClipboard.copy(number.text).then(
                                (value) => showToast("Number copied"),
                              ),
                              child: Container(
                                height: 50.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: fadedBorder,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.copy_rounded,
                                      color: weirdBlack50, size: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Email Address",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: email,
                            width: 414.w,
                            height: 50.h,
                            readOnly: true,
                            suffix: GestureDetector(
                              onTap: () =>
                                  FlutterClipboard.copy(email.text).then(
                                (value) => showToast("Email copied"),
                              ),
                              child: Container(
                                height: 50.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: fadedBorder,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.copy_rounded,
                                      color: weirdBlack50, size: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Twitter Page",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: twitter,
                            width: 414.w,
                            height: 50.h,
                            readOnly: true,
                            hint: "Oostel's Twitter Url",
                            prefix: SizedBox(
                              height: 50.h,
                              width: 30.w,
                              child: const Center(
                                  child: Icon(Boxicons.bxl_twitter,
                                      color: weirdBlack50, size: 20),
                              ),
                            ),
                            suffix: GestureDetector(
                              onTap: () =>
                                  FlutterClipboard.copy(twitter.text).then(
                                (value) => showToast("Twitter Url copied"),
                              ),
                              child: Container(
                                height: 50.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: fadedBorder,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.copy_rounded,
                                      color: weirdBlack50, size: 20),
                                ),
                              ),
                            ),
                            type: TextInputType.number,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Facebook Page",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: facebook,
                            width: 414.w,
                            height: 50.h,
                            readOnly: true,
                            hint: "Oostel's Facebook Url",
                            prefix: SizedBox(
                              height: 50.h,
                              width: 30.w,
                              child: const Center(
                                child: Icon(Boxicons.bxl_facebook_circle,
                                    color: weirdBlack50, size: 20),
                              ),
                            ),
                            suffix: GestureDetector(
                              onTap: () =>
                                  FlutterClipboard.copy(facebook.text).then(
                                (value) => showToast("Facebook Url copied"),
                              ),
                              child: Container(
                                height: 50.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: fadedBorder,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.copy_rounded,
                                      color: weirdBlack50, size: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Instagram Page",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: instagram,
                            width: 414.w,
                            height: 50.h,
                            readOnly: true,
                            hint: "Oostel's Instagram Url",
                            prefix: SizedBox(
                              height: 50.h,
                              width: 30.w,
                              child: const Center(
                                child: Icon(Boxicons.bxl_instagram,
                                    color: weirdBlack50, size: 20),
                              ),
                            ),
                            suffix: GestureDetector(
                              onTap: () =>
                                  FlutterClipboard.copy(instagram.text).then(
                                (value) => showToast("Instagram Url copied"),
                              ),
                              child: Container(
                                height: 50.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: fadedBorder,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.copy_rounded,
                                      color: weirdBlack50, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FAQ {
  final String question;
  final String answer;

  const _FAQ({required this.question, required this.answer});
}

class _FAQContainer extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> animation;
  final _FAQ faq;

  const _FAQContainer({
    super.key,
    required this.controller,
    required this.animation,
    required this.faq,
  });

  @override
  State<_FAQContainer> createState() => _FAQContainerState();
}

class _FAQContainerState extends State<_FAQContainer> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E5EC),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            )
          ]
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.faq.question,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => expand = !expand);
                    if (expand) {
                      widget.controller.forward();
                    } else {
                      widget.controller.reverse();
                    }
                  },
                  icon: Icon(
                    !expand
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                    color: weirdBlack50,
                  ),
                )
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: widget.animation,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, top: 10.h, right: 10.w, bottom: 20.h),
              child: Text(
                widget.faq.answer,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: weirdBlack75,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

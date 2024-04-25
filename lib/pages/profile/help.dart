import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class HelpPage extends ConsumerStatefulWidget {
  const HelpPage({super.key});

  @override
  ConsumerState<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends ConsumerState<HelpPage>
    with TickerProviderStateMixin {
  late TabController controller;
  final TextEditingController number =
      TextEditingController(text: "8112416080");
  final TextEditingController email =
      TextEditingController(text: "student@fyndasupport.com");
  final TextEditingController instagram = TextEditingController();
  final TextEditingController facebook = TextEditingController();
  final TextEditingController twitter = TextEditingController();

  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  late List<_FAQ> faqs;

  @override
  void initState() {
    super.initState();

    bool isStudent = ref.read(isAStudent), isAnAgent = ref.read(isAgent);

    faqs = isStudent
        ? const [
            _FAQ(
              question: "What is Fynda App?",
              answer:
                  "Fynda App is a mobile app that helps students in higher institutions effortlessly secure their "
                  "accommodation and collaborate with their desired roommate.\n\nThe Fynda App is a platform designed "
                  "to assist students in higher institutions to secure accommodation and find compatible roommates effortlessly.",
            ),
            _FAQ(
              question: "How can I use the Fynda App?",
              answer:
                  "Simply download the app, create an account, and start searching "
                  "for accommodation or roommates based on your preferences.",
            ),
            _FAQ(
              question: "How can I search for my desired hostel?",
              answer:
                  "To find a hostel, you can filter your search by location, price range, "
                  "and other criteria. Once you have found a hostel that you are interested in, you can view more "
                  "information about it, such as photos, amenities, and reviews.",
            ),
            _FAQ(
              question:
                  "How can I find and collaborate with my fellow student to be my roommate?",
              answer:
                  "To find a roommate, you can search by school level, gender, religion, budget range and other criteria. "
                  "Once you have found a potential roommate that you want to live with, you can send them a message through "
                  "Fynda App to start a conversation. You can use the app to chat with your roommate, share photos and videos, "
                  "and coordinate your move-in date.",
            ),
            _FAQ(
              question: "Can I trust the accommodations listed on Fynda?",
              answer: "We provide a platform for landlords and landladies to "
                  "list accommodations. While we aim to ensure the quality of listings, the ultimate responsibility for choosing "
                  "accommodation lies with you.",
            ),
            _FAQ(
              question: "How do I pay my hostel fees through Fynda App?",
              answer:
                  "To pay your hostel fees through Fynda App, you will need to enter your credit card or debit card information. "
                  "Fynda uses a secure payment processor to ensure that your payment information is protected.",
            ),
            _FAQ(
              question: "What if I need to cancel a booking/reservation?",
              answer:
                  "Cancellation policies vary by the landlord or landlady. The specific policy for each listing is communicated "
                  "during the booking process. Be sure to review these policies before confirming a booking.",
            ),
            _FAQ(
              question:
                  "Can I communicate with potential roommates through the app?",
              answer:
                  "Yes, you can communicate with potential roommates through our in-app messaging system.",
            ),
            _FAQ(
              question: "Is Fynda App safe?",
              answer:
                  "Yes, Fynda App is safe to use. We take reasonable steps to protect your personal information from unauthorized "
                  "access, use, or disclosure. However, no method of data transmission or storage is completely secure. "
                  "Therefore, we cannot guarantee the absolute security of your personal information.",
            ),
            _FAQ(
              question: "How do I contact Fynda for support or assistance?",
              answer:
                  "You can reach our support team by using the in-app help & support feature or by contacting us at "
                  "oostel.app@gmail.com",
            ),
            _FAQ(
              question: "How much does Fynda App cost?",
              answer:
                  "Fynda App is free to use for students. Landlords/landladies pay a small fee to list their hostels on the app.",
            ),
            _FAQ(
              question: "Can I use Fynda in multiple cities or countries?",
              answer:
                  "The availability of the Fynda App may vary by location. Please check the app to see if we "
                  "offer services in your desired area.",
            ),
            _FAQ(
              question: "Do you charge any fees for using the Fynda App?",
              answer:
                  "The Fynda App is free to download and use. However, please note that there may be fees associated "
                  "with accommodation bookings, which are determined by the respective landlords or landladies.",
            ),
            _FAQ(
              question: "How do I report an issue with a listing or a user?",
              answer:
                  "You can report issues through the app by using the help & support feature. We take such reports "
                  "seriously and investigate any violations of our Terms of Service.",
            ),
            _FAQ(
                question: "What devices is Fynda App available on?",
                answer:
                    "Fynda App is available on Android devices while iOS would launched later."),
            _FAQ(
              question: "How do I update my profile information on Fynda App?",
              answer:
                  "To update your profile information on Fynda App, go to the 'My Profile' section of the app and "
                  "tap on the 'Edit Profile' button.",
            ),
            _FAQ(
              question:
                  "What happens if I forget my password or have trouble accessing my account?",
              answer:
                  "You can reset your password through the app's 'Forgot Password' feature. If you encounter any "
                  "issues, please contact our support team for assistance.",
            ),
            _FAQ(
              question:
                  "How can I provide feedback or suggest improvements for the app?",
              answer:
                  "We value your feedback. You can share your suggestions and comments through the app or by "
                  "contacting our support team.",
            ),
            _FAQ(
              question:
                  "Do you offer any guarantees for accommodation quality or roommate compatibility?",
              answer:
                  "We do not offer guarantees, but we strive to provide a reliable platform. It's important to"
                  " thoroughly review listings and communicate with potential roommates to ensure a good fit.",
            )
          ]
        : !isAnAgent
            ? const [
                _FAQ(
                  question: "What is Fynda App?",
                  answer:
                      "Fynda App is a platform that helps landlords/landladies to market and manage their hostels to students in "
                      "higher institutions.",
                ),
                _FAQ(
                  question: "How can it benefit me as a landlord/landlady?",
                  answer:
                      "It provides a convenient way to connect with potential tenants and manage payments securely.",
                ),
                _FAQ(
                  question:
                      "How does Fynda App benefit me as a landlord/landlady?",
                  answer:
                      "Fynda App helps landlords/landladies to: \nList their hostels on the app and reach a large audience of "
                      "potential students \nProcess rental payments securely and efficiently \nManage their hostel bookings "
                      "and reservations \nCommunicate with their tenants directly through the app",
                ),
                _FAQ(
                  question:
                      "How do I get started as a landlord/landlady on the Fynda App?",
                  answer:
                      "To get started, download the app, create an account, and list your accommodations with details such as "
                      "location, room availability, rental rates etc.",
                ),
                _FAQ(
                  question: "How much does it cost to open an Fynda account?",
                  answer: "It is free to open an account on Fynda App.",
                ),
                _FAQ(
                  question:
                      "How can I receive payments for my hostel through the Fynda App?",
                  answer:
                      "The Fynda App facilitates secure payment processing through third-party payment providers. Tenants "
                      "can make payments through the app and the funds will be transferred to your local bank wallet.",
                ),
                _FAQ(
                  question:
                      "Can I set my own cancellation and refund policies for my accommodations?",
                  answer:
                      "Yes, you have control over setting and communicating your own cancellation and refund policies to tenants. "
                      "Tenants will be subject to the policies you specify.",
                ),
                _FAQ(
                  question:
                      "How do I communicate with my tenants through Fynda App?",
                  answer:
                      "Fynda App provides a built-in messaging system that allows you to communicate with your tenants directly. "
                      "You can use the messaging system to send and receive messages, share photos and videos, and coordinate move-in dates.",
                ),
                _FAQ(
                    question:
                        "How do I ensure the security and privacy of my personal information on the Fynda App?",
                    answer:
                        "We take data privacy seriously and implement security measures. Please refer to our Privacy Policy to "
                        "understand how we protect your data."),
                _FAQ(
                  question:
                      "Can I list accommodations in different locations within the Institution environment?",
                  answer:
                      "Yes, you can list accommodations in multiple locations, depending on your preferences and availability.",
                ),
                _FAQ(
                  question:
                      "How can I report issues with tenants or reservations?",
                  answer:
                      "You can report issues or violations through the app using the reporting feature. We take these reports "
                      "seriously and will investigate as needed.",
                ),
                _FAQ(
                  question:
                      "How do I communicate with potential tenants, and what is the messaging process like?",
                  answer:
                      "You can communicate with tenants through the app's messaging system. When a tenant is interested in your "
                      "accommodation, you can use this feature to discuss details and answer questions.",
                ),
                _FAQ(
                  question:
                      "Do you offer any assistance or support for landlord/landlady users?",
                  answer:
                      "Yes, we have a support team available to assist you with any questions, issues, or concerns you may have. "
                      "You can reach out for support directly through the app.",
                ),
                _FAQ(
                  question:
                      "Can I edit or update my accommodation listings after they are posted?",
                  answer:
                      "Yes, you have the ability to edit and update your listings at any time to reflect changes or updates in "
                      "your accommodations.",
                ),
                _FAQ(
                  question:
                      "Are there any specific guidelines I should follow as a landlord/landlady on the Fynda App?",
                  answer:
                      "Please adhere to the Fynda App's Terms of Service and follow any additional guidelines or community rules"
                      " that may be provided by the community in your area.",
                ),
                _FAQ(
                  question: "Is Fynda App safe?",
                  answer:
                      "Yes, Fynda App is safe to use. Fynda uses a variety of security measures to protect your information, "
                      "including:\nSecure payment processing\nData encryption\nFraud detection and prevention",
                ),
                _FAQ(
                  question:
                      "How can I provide feedback or suggestions to improve the Fynda App for landlords/landladies?",
                  answer:
                      "We appreciate your feedback. You can share your suggestions and comments through the app or by "
                      "contacting our support team.",
                ),
              ]
            : const [
                _FAQ(
                  question: "What is Fynda App?",
                  answer:
                      "Fynda App is a mobile app that helps agents to list and manage hostels for landlords.",
                ),
                _FAQ(
                  question: "What is the role of an Agent on Fynda App?",
                  answer:
                      "Agents on Fynda App assist Landlords in listing and managing hostels, including creating accurate property listings, managing property details, and facilitating communication with potential tenants.",
                ),
                _FAQ(
                  question:
                      "What is the minimum contract term for agents on Fynda App?",
                  answer:
                      "The minimum contract term for agents on Fynda App is determined by the landlord/landlady.",
                ),
                _FAQ(
                  question: "Can I work with multiple Landlords as an Agent?",
                  answer:
                      "Yes, Agents can work with multiple Landlords to assist in listing and managing their hostels.",
                ),
                _FAQ(
                  question:
                      "Are there any qualifications or requirements to become an Agent?",
                  answer:
                      "The qualifications and requirements would be determined by the landlord/landlady.",
                ),
                _FAQ(
                  question:
                      "How do I handle privacy and data protection as an Agent?",
                  answer:
                      "Agents are responsible for respecting the privacy and data protection rights of both Landlords and Tenants. Personal data should only be used for facilitating property management and listings.",
                ),
                _FAQ(
                  question:
                      "What should I do if I suspect fraudulent or unethical activities on the platform?",
                  answer:
                      "If you suspect fraudulent or unethical activities, report them to Fynda App support for investigation.",
                ),
                _FAQ(
                  question:
                      "Can I use personal photos and descriptions in hostel listings as an Agent?",
                  answer:
                      "It's important to use accurate and relevant information in hostel listings. Personal photos and descriptions should be related to the property and its features.",
                ),
                _FAQ(
                  question:
                      "How do I handle communication with Landlords and Tenants?",
                  answer:
                      "Maintain clear and respectful communication with all parties. Respond to messages and inquiries in a timely manner.",
                ),
                _FAQ(
                  question:
                      "Are there withdrawal restrictions for Agents on Fynda App?",
                  answer:
                      "Yes, Fynda App have withdrawal restrictions for Agents. Review and understand the withdrawal policies and timelines provided on the platform.",
                ),
                _FAQ(
                  question:
                      "What happens if a Landlord or Tenant has an issue with my services as an Agent?",
                  answer: "If an issue arises, try to resolve it amicably.",
                ),
                _FAQ(
                  question:
                      "Can I voluntarily terminate my account as an Agent?",
                  answer:
                      "Yes, you can voluntarily terminate your account by providing notice to Fynda App.",
                ),
                _FAQ(
                  question: "I have a question that is not answered here.",
                  answer:
                      "If you have a question that is not answered here, please contact Fynda App support at fynda.care@gmail.com",
                ),
              ];

    controller = TabController(vsync: this, length: 2);
    for (int i = 0; i < faqs.length; ++i) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
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
    UserType type = ref.watch(currentUserProvider).type;

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
          "Help & Support",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
          child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, something) => [
            SliverPersistentHeader(
                delegate: TabHeaderDelegate(
              tabBar: TabBar(
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
            ))
          ],
          body: TabBarView(
            controller: controller,
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverToBoxAdapter(
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
                            type == UserType.student
                                ? "Please note that these FAQs are provided for informational purposes and may not cover "
                                    "every specific question or scenario. If you have additional questions or need further "
                                    "assistance, please don't hesitate to reach out to us."
                                : "If you have additional questions or need further assistance as "
                                    "${type == UserType.landlord ? "a landlord or landlady" : "an agent"} on "
                                    "the Fynda App, please feel free to reach out to us. Your satisfaction and success as a "
                                    "host are important to us.",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          if (index == faqs.length) {
                            return SizedBox(height: 50.h);
                          }

                          return Column(
                            children: [
                              _FAQContainer(
                                controller: controllers[index],
                                animation: animations[index],
                                faq: faqs[index],
                              ),
                              SizedBox(height: 16.h),
                            ],
                          );
                        },
                        childCount: faqs.length + 1,
                      ),
                    ),
                  ),
                ],
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
                        "Have questions or feedback? We're here to help you. Reach out "
                            "to our support team, and we'll assist you promptly.",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Phone Number",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
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
                          onTap: () async =>
                              launchContactUrl("0${number.text}"),
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
                              child: Icon(Icons.phone_rounded,
                                  color: weirdBlack50, size: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Email Address",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: email,
                        width: 414.w,
                        height: 50.h,
                        readOnly: true,
                        suffix: GestureDetector(
                          onTap: () async => launchEmail(email.text),
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
                              child: Icon(Icons.mail_rounded,
                                  color: weirdBlack50, size: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Twitter Page",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: twitter,
                        width: 414.w,
                        height: 50.h,
                        readOnly: true,
                        hint: "Fynda's Twitter Url",
                        prefix: SizedBox(
                          height: 50.h,
                          width: 30.w,
                          child: const Center(
                            child: Icon(Boxicons.bxl_twitter,
                                color: weirdBlack50, size: 20),
                          ),
                        ),
                        suffix: GestureDetector(
                          onTap: () async => launchSocialMediaUrl(twitter.text),
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
                              child: Icon(Icons.link,
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
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: facebook,
                        width: 414.w,
                        height: 50.h,
                        readOnly: true,
                        hint: "Fynda's Facebook Url",
                        prefix: SizedBox(
                          height: 50.h,
                          width: 30.w,
                          child: const Center(
                            child: Icon(Boxicons.bxl_facebook_circle,
                                color: weirdBlack50, size: 20),
                          ),
                        ),
                        suffix: GestureDetector(
                          onTap: () async =>
                              launchSocialMediaUrl(facebook.text),
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
                              child: Icon(Icons.link,
                                  color: weirdBlack50, size: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Instagram Page",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: instagram,
                        width: 414.w,
                        height: 50.h,
                        readOnly: true,
                        hint: "Fynda's Instagram Url",
                        prefix: SizedBox(
                          height: 50.h,
                          width: 30.w,
                          child: const Center(
                            child: Icon(Boxicons.bxl_instagram,
                                color: weirdBlack50, size: 20),
                          ),
                        ),
                        suffix: GestureDetector(
                          onTap: () async =>
                              launchSocialMediaUrl(instagram.text),
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
                              child: Icon(Icons.link,
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
        ),
      )),
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
      padding: EdgeInsets.only(
          left: 20.w, right: 10.w, bottom: expand ? 20.h : 10.h, top: 10.h),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 280.w,
                child: Text(
                  widget.faq.question,
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => expand = !expand);
                  if (expand) {
                    widget.controller.forward();
                  } else {
                    widget.controller.reverse();
                  }
                },
                child: Icon(
                  !expand
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: weirdBlack50,
                ),
              )
            ],
          ),
          SizeTransition(
            sizeFactor: widget.animation,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  widget.faq.answer,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

class PrivacyPolicyPage extends ConsumerWidget {
  const PrivacyPolicyPage({super.key});

  Widget get studentPolicy => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1. Information We Collect",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t1.1 User-Provided Information: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                        "We may collect information that you provide when using the App, including but not limited to "
                            "your name, email address, phone number, and other details necessary for creating an account.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t1.2 Accommodation Information: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "When you book accommodation through the App, we may collect information "
                        "related to your accommodation preferences, such as location, type of room, and duration of stay.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t1.3 Payment Information: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "To facilitate accommodation payments, we may collect payment details, including "
                        "credit card information. Please note that we use secure third-party payment "
                        "processors to handle payments, and we do not store your payment information "
                        "on our servers.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t1.4 Communication: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We may collect information from your communications with us, "
                        "including messages sent through the App or emails "
                        "sent to our support team.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "2. How We Use Your Information",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'We use the collected information for the following purposes: ',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: weirdBlack75),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t2.1 To Provide Services: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We use your information to offer the services provided by the App, "
                        "including facilitating accommodation bookings, payments, and connecting "
                        "you with landlords or landladies.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t2.2 Communication: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We may use your contact information to communicate with you "
                        "regarding your bookings, account updates, or support requests.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t2.3 Improvement of Services: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "Your feedback and usage patterns help us enhance the App's "
                        "functionality and user experience.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t2.4 Legal Requirements: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We may use your information to comply with legal obligations, "
                        "resolve disputes, or enforce our Terms of Service.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "3. Information Sharing",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'We do not sell or rent your personal information to third parties. '
                  'However, we may share your information in the following circumstances: ',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: weirdBlack75),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t3.1 Service Providers: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We may share information with third-party service providers "
                        "who help us with services like payment processing,"
                        " customer support, or data analysis.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t3.2 Landlord/Landladies: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We share necessary information with accommodation providers "
                        "to facilitate your bookings and ensure a smooth accommodation experience.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "\t\t3.3 Legal Compliance: ",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text:
                    "We may disclose your information if required to do so by law, "
                        "or in response to legal processes, to protect our rights, "
                        "or to prevent fraud or safety issues.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "4. Data Security",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'We take appropriate measures to protect your personal information. '
                  'We use industry-standard security practices to safeguard your data '
                  'against unauthorized access, disclosure, or alteration.',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: weirdBlack75),
            ),
            SizedBox(height: 16.h),
            Text(
              "5. Your Choices and Access",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'You can access, correct, or delete your personal information '
                  'through the App. You may also contact us to exercise these'
                  ' rights or if you have questions about your data.',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: weirdBlack75),
            ),
            SizedBox(height: 16.h),
            Text(
              "6. Changes to this Privacy Policy",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'We may update this Privacy Policy to reflect changes in our practices or'
                  ' for legal or operational reasons. When we make changes, we will revise '
                  'the "Last Updated" date at the top of this policy.',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, color: weirdBlack75),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          "Privacy Policy",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This Privacy Policy outlines how Fynda ("we," "us," or "our") collects, uses, discloses, '
                  'and safeguards your personal information when you use the Fynda App (the "App"). We are committed to respecting your privacy and protecting your data. Please read this Privacy Policy carefully to understand how we handle your information.',
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500, color: weirdBlack75),
                ),
                SizedBox(height: 32.h),
                studentPolicy,
                SizedBox(height: 16.h),
                Text(
                  "7. Contact Us",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 16.h),
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'If you have questions, concerns, or requests regarding your privacy or '
                              'this Privacy Policy, please contact us at ',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500, color: weirdBlack75),
                        ),
                        TextSpan(
                            text: "+2349012111170",
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500, color: appBlue),
                            recognizer: TapGestureRecognizer()..onTap = () async => launchContactUrl("09012111170")
                        ),
                        TextSpan(
                          text: " or ",
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500, color: weirdBlack75),
                        ),
                        TextSpan(
                            text: "fynda.care@gmail.com",
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500, color: appBlue),
                            recognizer: TapGestureRecognizer()..onTap = () async => launchEmail("fynda.care@gmail.com")
                        )
                      ]
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'By using the Fynda App, you consent to the practices described in this Privacy Policy. '
                      'Your continued use of the App signifies your acceptance of this policy.',
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500, color: weirdBlack75),
                ),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Container(
                    width: 414.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: appBlue,
                    ),
                    child: Text(
                      "Done",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                const Center(child: Copyright()),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

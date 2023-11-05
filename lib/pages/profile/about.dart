import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  Widget get studentTerms => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Creation and Use",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "To use the Fynda App, you must create an account and provide certain information, "
              "such as your name, email address, and phone number. You must also create a "
              "password and agree to keep it confidential.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Payment of Hostel Fees",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "The Fynda App provides a platform for students to search for, view, and book "
              "accommodation with landlords or landladies. We do not own, operate, or control "
              "the properties listed on the App. Accommodation availability, terms, and prices "
              "are determined by the respective landlords or landladies.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "You can use the Fynda App to pay your hostel fees directly to the landlord/landlady. "
              "To do this, you will need to enter your payment information into the app.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Fynda uses a secure payment processor to ensure that your payment information is protected. "
              "Fynda is not responsible for any unauthorized charges made to your account.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Roommate Collaboration",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "The Fynda App allows you to collaborate with other students to find a roommate. "
              "You can search for roommates by location, school level, gender, religion and budget range.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Once you have found a potential roommate, you can send them a message through the Fynda App "
              "to start a conversation.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Cancellation and Refund Policy",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Cancellation and refund policies are determined by the specific landlord or landlady and are "
              "communicated during the booking process. Fynda is not responsible for any refunds, and all"
              " disputes should be resolved directly with the accommodation provider.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "User Responsibilities",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "You agree to use the App responsibly and not to engage in any unlawful, harmful, or disruptive activities "
              "while using the service. You also agree not to violate the rights or privacy of "
              "others while using the App.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Intellectual Property",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "The Fynda App and all of its content are protected by copyright and other intellectual property laws. You "
              "agree not to copy, distribute, or modify the Fynda App or its content without the express written "
              "permission of Fynda.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Privacy",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Your use of the Fynda App is subject to our Privacy Policy, which outlines how we collect,"
              " use, and disclose your personal information. Please review our Privacy Policy to understand "
              "our data practices.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Rules and Regulation",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "To ensure a safe and positive experience for all Fynda App users, we have established the following "
              "rules and regulations. By using our platform, you agree to abide by these guidelines.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Honest and Accurate Information: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Provide accurate, truthful, and up-to-date information in your user profile and listings. '
                        'Misrepresenting yourself or your accommodation is not allowed.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Respect and Consideration: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Treat all users with respect and consideration. Discrimination, harassment, or any '
                        'form of disrespectful behaviour will not be tolerated.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Privacy and Confidentiality: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: "Respect the privacy and confidentiality of other users. Do not share personal contact information "
                        "(phone numbers, email addresses, etc.) within the app's messaging system.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Payment Compliance: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'When booking accommodation, ensure that you comply with the payment terms and '
                        'schedules as communicated by the landlord or landlady. And avoid paying for hostel'
                        ' reservation without using this platform because of receipt generation and security & '
                        'reference purpose.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Cancellation Policy: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Adhere to the cancellation policies specified by the landlord or landlady '
                        'when making a booking. Cancellations should be made in accordance with the '
                        'provided guidelines.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Reporting Issues: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'If you encounter any issues, violations of our rules, or feel unsafe, '
                        'please use the in-app reporting feature to notify us. We take all reports seriously '
                        'and will investigate as needed.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 No Illegal Activity: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Do not engage in any illegal activities, including '
                        'but not limited to theft, fraud, or the distribution '
                        'of illegal substances.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Accommodation Maintenance: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'As a tenant, maintain the rented accommodation in good'
                        ' condition and report any issues promptly to the landlord or landlady.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Roommate Compatibility: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'When seeking or sharing accommodation with roommates, '
                        'communicate openly about your expectations and house rules to '
                        'ensure a harmonious living situation.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Feedback and Reviews: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Provide honest and constructive feedback in reviews to help '
                        'improve the Fynda App. Avoid posting false or malicious reviews.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Appropriate Content: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Refrain from posting offensive, explicit, or inappropriate content '
                        'on the app, including in your profile, listings, or messages.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Security: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Protect your account by using strong and secure passwords. '
                        'Do not share your login credentials with others.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Community Guidelines: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Follow any additional community guidelines or specific rules '
                        'provided by the community in your location or chosen accommodation.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Compliance with Terms: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: "Adhere to the Fynda App's Terms of Service and Privacy Policy. Violating these "
                        "terms may result in the suspension or termination of your account.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Assistance and Support: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Reach out to Fynda support for assistance or clarification of rules, '
                        'should you need it. We are here to help resolve issues and provide guidance.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget get landlordTerms => Builder(
    builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Acceptance of Terms",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "By using the Fynda App, you accept and agree to be bound by these Terms, "
                  "including any updates or changes that may be made from time to time. "
                  "If you do not agree with these Terms, do not use the App. Account Creation "
                  "and Use To use the Fynda App, you must create an account and provide certain "
                  "information, such as your name, email address, and phone number. You must also "
                  "create a password and agree to keep it confidential. You are responsible for "
                  "maintaining the confidentiality of your account information and are solely "
                  "responsible for all activities that occur under your account. You agree to "
                  "provide accurate and complete information when creating your account.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Hostel Listing",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "The Fynda App allows you to list your hostels and accommodations for students to discover and "
                  "book. You are responsible for providing accurate and up-to-date information about your "
                  "accommodations, including location, available rooms, rental rates, hostel facilities, "
                  "photos, videos and rules and regulations guiding the hostel.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Payment Processing",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Through the Fynda App, you can receive payments for booked accommodations. Payments will be processed "
                  "and transferred to your local bank wallet through secure third-party payment processors. "
                  "You agree to provide accurate and complete payment information and understand "
                  "that transaction fees may apply.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "In addition to the following terms apply to receiving hostel payments through the Fynda App:",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text('\t\u2022 You must provide a valid local bank wallet account in order to receive '
                'payments through the Fynda App.',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            Text('\t\u2022 Fynda may charge a small fee for processing hostel payments.',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            Text('\t\u2022 Fynda reserves the right to withhold payments if it believes that'
                ' there is a fraudulent or suspicious activity.',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Cancellation and Refund Policy",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "You are responsible for setting and communicating your cancellation and refund policies "
                  "to tenants. Fynda is not responsible for refunds, and all disputes regarding "
                  "cancellations should be resolved directly with the tenants.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Content and Conduct",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "You are responsible for all content that you post or upload to the Fynda App. You agree not to "
                  "post or upload any content that is illegal, harmful, threatening, abusive, harassing, vulgar, "
                  "obscene, defamatory, or otherwise objectionable. You also agree not to use the Fynda App to "
                  "engage in any activity that is disruptive or harmful to the app or its users.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Privacy",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Your use of the Fynda App is subject to our Privacy Policy, which outlines how we collect, "
                  "use, and disclose your personal information. Please review our Privacy Policy to "
                  "understand our data practices.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "User Responsibilities",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "You agree to use the App responsibly and not to engage in any unlawful, harmful, or "
                  "disruptive activities while using the service. You also agree not to violate the "
                  "rights or privacy of others while using the App.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Rules and Regulations",
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "To create a positive and secure environment for both landlords/landladies and tenants, we "
                  "have established the following rules and regulations for Fynda App users in the role "
                  "of a landlord/landlady. By using our platform, you agree to adhere to these guidelines:",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Accurate and Up-to-Date Listings: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Provide accurate, complete, and up-to-date information about your '
                        'accommodations, including room availability, rental rates, amenities, and any house rules.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Privacy and Confidentiality: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: "Respect the privacy and confidentiality of tenant information. Do not share personal "
                        "contact information within the app's messaging system.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Secure and Responsible Payment Handling: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Ensure secure and transparent handling of payments through the app. Do not request '
                        'payments outside of the platform or engage in any fraudulent financial transactions.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Cancellation and Refund Policies: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: "Clearly communicate your accommodation's cancellation and refund policies "
                        "to tenants. Honour the policies you specify and handle cancellations "
                        "in accordance with these policies.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Respectful and Non-Discriminatory Behaviour: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Treat all tenants with respect, regardless of their background, nationality, or personal '
                        'characteristics. Discrimination or any form of harassment will not be tolerated.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Transparent Communication: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Communicate openly and transparently with potential tenants about the terms and conditions of '
                        'your accommodations, including any house rules, policies, and expectations.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Maintenance and Cleanliness: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Maintain your accommodations in good condition and ensure they are clean and '
                        'safe for tenants. Promptly address any issues or maintenance requests.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Prompt Response: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Respond to tenant inquiries, booking requests, and messages in a timely and '
                        'professional manner. Good communication is key to a positive rental experience.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Tenant Privacy and Data Protection: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Safeguard tenant information and data privacy. Do not misuse or share '
                        'tenant information for purposes other than the rental transaction.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Respectful Use of Reviews and Feedback: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Use reviews and feedback constructively and honestly. Do not post false or malicious reviews. '
                        'Address any disputes or issues professionally and privately with tenants.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Compliance with Local Laws and Regulations: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Ensure that your accommodations comply with all local laws '
                        'and regulations, including safety and building codes.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Proper Maintenance of Your Fynda Account: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Maintain your Fynda account responsibly, including '
                        'keeping your account information up to date and secure. '
                        'Do not share your login credentials with others.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Accountability for Accommodation Accuracy: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Be accountable for the accuracy of your accommodation listings. '
                        'Update your listings to reflect any changes or updates.',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Communitiy Guidelines: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: "Follow any additional community guidelines or specific rules "
                        "provided by the Fynda community in your location or chosen accommodation.",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\t\u2022 Cooperation with Fynda Support: ',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                  TextSpan(
                    text: 'Cooperate with Fynda support in case of issues, disputes, or reported violations. '
                        'Provide any requested information or assistance for investigations.',
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
              "By using the Fynda App as a landlord or landlady, you acknowledge that you have read and "
                  "agreed to these rules and regulations. We expect all users to maintain a professional, "
                  "respectful, and responsible presence on our platform to create a positive experience "
                  "for everyone.",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
          ],
        ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserType type = ref.read(currentUserProvider).type;
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
          "Terms of Service",
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
                  type == UserType.student ?
                  'These Terms of Service ("Terms") govern the use of the Fynda App (the "App"),'
                  ' a platform that assists students in higher institutions in securing '
                  'accommodation and collaborating with their desired roommates. '
                  'By accessing or using the App, you agree to comply with and be bound by '
                  'these Terms. Please read them carefully.' :
                  'These Terms of Service ("Terms") govern the use of the Fynda App (the "App") by '
                      'landlords and landladies who wish to market and manage their hostels to students '
                      'in higher institutions and receive payments through the Fynda App to their local '
                      'bank wallet. By accessing or using the App, you agree to comply with and be bound '
                      'by these Terms. Please read them carefully.'
                  ,
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500, color: weirdBlack75),
                ),
                SizedBox(height: 32.h),
                type == UserType.student
                    ? studentTerms
                    : landlordTerms,
                SizedBox(height: 16.h),
                Text(
                  "Termination",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "We reserve the right to terminate or suspend your account and access to the App at our discretion, "
                      "with or without notice, if you violate these Terms or engage in any activity that we deem harmful to "
                      "the App or its users.",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Changes to Terms of Service",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "We may update or modify these Terms from time to time. Any changes will be effective upon posting, "
                  "and it is your responsibility to review these Terms periodically. Your continued use of the App after "
                  "any changes constitutes your acceptance of the modified Terms.",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Contact Information",
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 16.h),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          'If you have questions, concerns, or requests regarding your privacy or '
                          'these Terms of Service, please contact us at ',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500, color: weirdBlack75),
                    ),
                    TextSpan(
                        text: "+2349012111170",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: appBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () async => launchContactUrl("09012111170")),
                    TextSpan(
                      text: " or ",
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500, color: weirdBlack75),
                    ),
                    TextSpan(
                        text: "fynda.care@gmail.com",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: appBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () async => launchEmail("fynda.care@gmail.com"))
                  ]),
                ),
                SizedBox(height: 16.h),
                Text(
                  'By using the Fynda App${type == UserType.landlord ? " as a landlord or landlady" : ""}, you acknowledge that you have read, understood, and agreed to '
                  'these Terms of Service. These Terms are a legal agreement between you and Fynda, so please '
                  'make sure you fully comprehend them before using the App.',
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

import 'package:flutter/material.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

export 'package:my_hostel/pages/home/landlord/edit-hostel.dart'
    show saveAndExit;
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_eight.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_five.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_four.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_nine.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_one.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_seven.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_six.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_ten.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_three.dart';
export 'package:my_hostel/pages/home/landlord/edit_hostel/step_two.dart';

void saveAndExit({
  required HostelInfoData info,
  required BuildContext context,
  GlobalKey<FormState>? formKey,
}) {
  if (formKey != null && !validateForm(formKey)) return;

  // updateHostel(info).then((resp) {
  //   if (!resp.success) {
  //     showError(resp.message);
  //     Navigator.of(context).pop();
  //     return;
  //   }
  //   context.router.pop();
  // });
  //
  // showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (_) => const Dialog(
  //     elevation: 0.0,
  //     backgroundColor: Colors.transparent,
  //     child: loader,
  //   ),
  // );
}

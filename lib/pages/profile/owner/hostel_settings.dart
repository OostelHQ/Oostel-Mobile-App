import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class HostelSettingsPage extends ConsumerStatefulWidget {
  const HostelSettingsPage({super.key});

  @override
  ConsumerState<HostelSettingsPage> createState() => _HostelSettingsPageState();
}

class _HostelSettingsPageState extends ConsumerState<HostelSettingsPage> {
  late TextEditingController name;
  late TextEditingController number;
  late TextEditingController area;
  late TextEditingController junction;
  late TextEditingController state;
  late TextEditingController country;

  @override
  void initState() {
    super.initState();

    HostelInfo info = ref.read(ownerHostelsProvider).first;

    name = TextEditingController(text: info.name);
    number = TextEditingController();
    area = TextEditingController();
    junction = TextEditingController();
    state = TextEditingController();
    country = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    number.dispose();
    area.dispose();
    junction.dispose();
    state.dispose();
    country.dispose();
    super.dispose();
  }

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
          "Hostel",
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
                  "Update your hostel details as needed. Keep your listing accurate and attractive to potential tenants.",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Hostel Name",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: name,
                  width: 414.w,
                  height: 50.h,
                  hint: "Name of your hostel",
                ),
                SizedBox(height: 16.h),
                Text(
                  "Hostel Identification Number",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: number,
                  width: 414.w,
                  height: 50.h,
                  hint: "i.e Zone B",
                ),
                SizedBox(height: 16.h),
                Text(
                  "Hostel Area",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: area,
                  width: 414.w,
                  height: 50.h,
                  hint: "i.e Behind Abans Factory",
                ),
                SizedBox(height: 16.h),
                Text(
                  "Hostel Junction",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: junction,
                  width: 414.w,
                  height: 50.h,
                  hint: "i.e Accord Junction",
                ),
                SizedBox(height: 16.h),
                Text(
                  "State/Region",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: state,
                  width: 414.w,
                  height: 50.h,
                  hint: "i.e Ogun State",
                ),
                SizedBox(height: 16.h),
                Text(
                  "Country/Nation",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: country,
                  width: 414.w,
                  height: 50.h,
                  hint: "i.e Nigeria",
                ),
                SizedBox(height: 100.h),
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
                      "Save Changes",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

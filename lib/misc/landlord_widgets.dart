import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';

import 'widgets.dart';

class LandlordHostelCard extends StatelessWidget {
  final HostelInfo info;

  const LandlordHostelCard({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                info.media[0],
                width: 414.w,
                height: 156.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Hero(
                    tag: "Hostel ID: ${info.id} Name: ${info.name}",
                    child: Text(
                      info.name,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: infoRoomsLeftBackground,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "${info.roomsLeft.length}/${info.totalRooms} room${info.roomsLeft.length == 1 ? "" : "s"} left",
                    style: context.textTheme.bodySmall!.copyWith(
                      color: infoRoomsLeft,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              joinToAddress(info.address),
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500, color: weirdBlack75,
              ),
            )
          ],
        ),
      ),
    );
  }
}

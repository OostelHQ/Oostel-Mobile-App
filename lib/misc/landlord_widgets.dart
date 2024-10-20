import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

class LandlordHostelCard extends StatefulWidget {
  final HostelInfo info;

  const LandlordHostelCard({
    super.key,
    required this.info,
  });

  @override
  State<LandlordHostelCard> createState() => _LandlordHostelCardState();
}

class _LandlordHostelCardState extends State<LandlordHostelCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(Pages.ownerHostelInfo, extra: widget.info),
      child: Container(
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.info.media.first,
              errorWidget: (context, url, error) => Container(
                width: 414.w,
                height: 156.h,
                color: weirdBlack50,
              ),
              progressIndicatorBuilder: (context, url, download) =>
                  Container(
                    width: 414.w,
                    height: 156.h,
                    color: weirdBlack50,
                    alignment: Alignment.center,
                    child: loader,
                  ),
              imageBuilder: (context, provider) => Container(
                width: 414.w,
                height: 156.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: provider,
                    fit: BoxFit.cover,
                  ),
                ),
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
                    tag: "Hostel ID: ${widget.info.id} Name: ${widget.info.name}",
                    child: Text(
                      widget.info.name,
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
                    "${widget.info.rooms.length}/${widget.info.totalRooms} room${widget.info.totalRooms == 1 ? "" : "s"} left",
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
              joinToAddress(widget.info.address, ignoreFourth: true),
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: weirdBlack75,
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}

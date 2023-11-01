import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/notification.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:timeago/timeago.dart' as time;

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationData> notifications = ref.watch(notificationsProvider);

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
          "Notifications",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
        actions: [
          IconButton(
            iconSize: 26.r,
            splashRadius: 20.r,
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            itemBuilder: (_, index) {
              if (index == notifications.length) {
                return SizedBox(height: 48.h);
              }
              return _NotificationCard(
                data: notifications[index],
                onRemove: () => notifications.removeAt(index),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 15.h),
            itemCount: notifications.length + 1,
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationData data;
  final VoidCallback onRemove;

  const _NotificationCard({
    super.key,
    required this.data,
    required this.onRemove,
  });

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
          ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(data.image),
            radius: 16.r,
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 290.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Message",
                      style: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(Boxicons.bx_x, size: 18),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  data.message,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time,
                        color: weirdBlack50, size: 14),
                    SizedBox(width: 5.w),
                    Text(
                      time.format(data.timestamp),
                      style: context.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack50,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/api/message_service.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'inbox.dart';


class Detail {
  final String name;
  final String image;
  final String content;
  final DateTime time;
  final int unread;
  final String otherID;

  const Detail({
    this.name = "Lorem Ipsum",
    this.image = "",
    required this.time,
    this.unread = 0,
    this.otherID = "",
    this.content = "Lorem Ipsum Dolor Natem Lorem",
  });
}

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  final TextEditingController controller = TextEditingController();
  final List<Detail> details = [];
  bool loaded = false;

  late HubConnection connection;

  @override
  void initState() {
    super.initState();
    getMessages(ref.read(currentUserProvider).email)
        .then((resp) => setState(() => loaded = true));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() => loaded = false);
        getMessages(ref.watch(currentUserProvider).email)
            .then((resp) => setState(() => loaded = true));
      },
      child: !loaded
          ? const Center(child: blueLoader)
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  expandedHeight: 150.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),
                          GestureDetector(
                            onTap: () => context.router.pushNamed(
                              Pages.inbox,
                              extra: const InboxInfo(
                                id: "c59e6aaf-4ef5-4d4a-b4c5-cdc41f10bded",
                                role: "Student",
                              ),
                            ),
                            child: Text(
                              "Chats",
                              style: context.textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SpecialForm(
                            controller: controller,
                            width: 414.w,
                            height: 50.h,
                            fillColor: Colors.white,
                            hint: "Search name",
                            prefix: const Icon(Icons.search_rounded,
                                color: weirdBlack25),
                            action: TextInputAction.send,
                            borderColor: Colors.transparent,
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
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
                !loaded
                    ? SliverFillRemaining(
                        child: Skeletonizer(
                          enabled: true,
                          child: ListView.separated(
                            itemCount: 20,
                            itemBuilder: (_, index) => ChatTile(
                              detail: Detail(time: DateTime.now()),
                            ),
                            separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) => ChatTile(
                              detail: details[index],
                            ),
                            childCount: details.length,
                          ),
                        ),
                      )
              ],
            ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final Detail detail;

  const ChatTile({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.router.pushNamed(Pages.inbox, extra: detail.otherID),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: SizedBox(
        width: 60.r,
        height: 60.r,
        child: CircleAvatar(
          backgroundImage:
              detail.image.isEmpty ? null : AssetImage(detail.image),
          backgroundColor: weirdBlack20,
          radius: 48.r,
        ),
      ),
      title: SizedBox(
        height: 20.r,
        child: Text(
          detail.name,
          style: context.textTheme.bodyMedium!.copyWith(
            color: weirdBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      subtitle: SizedBox(
        height: 35.r,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            detail.content,
            style: context.textTheme.bodySmall!.copyWith(
              color: weirdBlack75,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 60.r,
        height: 60.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "8:03 PM",
              style: context.textTheme.bodySmall!.copyWith(
                color: weirdBlack75,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (detail.unread > 0)
              bg.Badge(
                showBadge: true,
                badgeContent: Text(
                  "${detail.unread}",
                  style: context.textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

import 'package:badges/badges.dart' as bg;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/api/message_service.dart';
import 'package:my_hostel/components/conversation.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart';

import 'inbox.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  final TextEditingController controller = TextEditingController();
  final List<Conversation> conversations = [];
  // bool loaded = false;
  bool loaded = true;

  late InboxInfo inboxInfo;

  @override
  void initState() {
    super.initState();
    inboxInfo = const InboxInfo(
        id: "d9958db3-c3d4-4c35-a962-910e5d79721b", role: "Student");
    refresh();
  }

  Future<void> refresh() async {
    List<Conversation> data = [];
        // (await getAllConversations(ref.read(currentUserProvider).id)).payload;
    if (!mounted) return;

    if(data.isEmpty) {
      setState(() => loaded = true);
      return;
    }

    conversations.clear();
    conversations.addAll(data);

    setState(() => loaded = true);
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
        refresh();
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
                          Text(
                            "Chats",
                            style: context.textTheme.headlineSmall!
                                .copyWith(fontWeight: FontWeight.w600),
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
                              conversation: Conversation.dummy(),
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
                              conversation: conversations[index],
                            ),
                            childCount: conversations.length,
                          ),
                        ),
                      )
              ],
            ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final Conversation conversation;

  const ChatTile({
    super.key,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.router.pushNamed(
        Pages.inbox,
        extra: InboxInfo(
          id: conversation.otherUser,
          role: "Student",
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: CachedNetworkImage(
        imageUrl: defaultAvatar,
        errorWidget: (_, __, err) => CircleAvatar(
          backgroundColor: weirdBlack75,
          radius: 24.r,
        ),
        progressIndicatorBuilder: (_, __, err) => CircleAvatar(
          backgroundColor: weirdBlack20,
          radius: 24.r,
        ),
        imageBuilder: (_, provider) => CircleAvatar(
          backgroundImage: provider,
          radius: 24.r,
        ),
      ),
      title: SizedBox(
        height: 20.r,
        child: Text(
          "Test Conversation",
          style: context.textTheme.bodyLarge!.copyWith(
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
            conversation.lastMessage,
            style: context.textTheme.bodyMedium!.copyWith(
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
              formatTime(conversation.timeStamp),
              style: context.textTheme.bodySmall!.copyWith(
                color: weirdBlack75,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (conversation.unreadMessages > 0)
              bg.Badge(
                showBadge: true,
                badgeContent: Text(
                  "${conversation.unreadMessages}",
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

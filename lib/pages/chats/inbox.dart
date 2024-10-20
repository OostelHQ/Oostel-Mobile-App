import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/api/database_service.dart';

import 'package:my_hostel/api/message_service.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/components/message.dart' as m;
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class InboxInfo {
  final String id;
  final String role;

  const InboxInfo({
    required this.id,
    required this.role,
  });
}

class Inbox extends ConsumerStatefulWidget {
  final InboxInfo info;

  const Inbox({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<Inbox> createState() => _InboxState();
}

class _InboxState extends ConsumerState<Inbox> {
  late ChatController chatController;

  User? otherUser;
  late String currentUserID, otherUserID;

  bool loading = true, hasError = false;

  @override
  void initState() {
    super.initState();

    currentUserID = ref.read(currentUserProvider).id;
    otherUserID = widget.info.id;

    chatController = ChatController(
      initialMessageList: [],
      currentUser: ChatUser(
        id: currentUserID,
        name: ref.read(currentUserProvider).mergedNames,
        profilePhoto: ref.read(currentUserProvider).image,
      ),
      otherUsers: [],
      scrollController: ScrollController(),
    );

    initialize();
  }

  Future<void> initialize() async {
    if (widget.info.role == "Student") {
      otherUser = (await getStudentById(otherUserID)).payload;
    } else if (widget.info.role == "Landlord") {
      otherUser = (await getLandlordById(otherUserID)).payload;
    } else {
      otherUser = (await getAgentById(otherUserID)).payload;
    }

    if (otherUser == null) {
      if (!mounted) return;
      setState(() {
        loading = false;
        hasError = true;
      });
      return;
    }

    // users.add(ChatUser(
    //   id: otherUserID,
    //   name: otherUser!.mergedNames,
    //   profilePhoto: otherUser!.image,
    // ));

    getInitialMessages();
  }

  Future<void> getInitialMessages() async {
    List<m.Message> messages =
        await DatabaseManager.getMessagesBetween(currentUserID, otherUserID);
    assignMessages(messages);
    getMessagesFromServer();
  }

  void assignMessages(List<m.Message> messages,
      {bool online = false, bool consistent = true}) {
    List<Message> msgs = messages
        .map(
          (msg) => Message(
            message: msg.content,
            createdAt: msg.dateSent,
            sentBy: msg.senderId,
            id: msg.id,
          ),
        )
        .toList();

    if (online) {
      // chatController.removeAllMessages();
    }

    // chatController.addMessages(msgs);
    setState(() {
      if (!online) {
        loading = false;
        hasError = false;
      }
    });
  }

  Future<void> getMessagesFromServer() async {
    var resp = await getMessages({
      "senderId": currentUserID,
      "receiverId": otherUserID,
    });

    if (!mounted) return;

    if (!resp.success) {
      showError(resp.message);
      setState(() {
        loading = false;
        hasError = true;
      });
      return;
    }

    bool consistent = true;
    //resp.payload.length != chatController.numberOfMessages
    if (resp.payload.length != 0) {
      await DatabaseManager.clearAllMessages();
      await DatabaseManager.addMessages(resp.payload);
      consistent = false;
    }

    assignMessages(resp.payload, online: true, consistent: consistent);
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  void onSendTap(String rawMessage, ReplyMessage replyMessage,
      MessageType messageType) async {
    DateTime time = DateTime.now();
    final message = Message(
      id: time.millisecondsSinceEpoch.toString(),
      message: rawMessage,
      createdAt: time,
      sentBy: currentUserID,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    chatController.addMessage(message);

    sendMessage({
      "message": rawMessage,
      "senderId": currentUserID,
      "receiverId": otherUserID,
    }).then((resp) {
      if (!mounted) return;
      if (!resp.success) {
        showError(resp.message);
        return;
      }
      DatabaseManager.addMessage(resp.payload!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChatView(
          // currentUser: users.first,
          chatController: chatController,
          appBar: ChatViewAppBar(
            elevation: 0.0,
            leading: IconButton(
              iconSize: 26.r,
              splashRadius: 20.r,
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: () => context.router.pop(),
            ),
            profilePicture: ref.watch(currentUserProvider).image,
            chatTitle:  "",//users.length > 1 ? users[1].name : "",
            userStatus: "Online",
            chatTitleTextStyle: context.textTheme.bodyLarge!.copyWith(
              color: weirdBlack,
              fontWeight: FontWeight.w600,
            ),
            userStatusTextStyle: context.textTheme.bodyMedium!.copyWith(
              color: weirdBlack75,
              fontWeight: FontWeight.w500,
            ),
            backGroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => const _InboxMenu(),
                  isScrollControlled: true,
                ),
                iconSize: 26.r,
                splashRadius: 20.r,
              ),
            ],
          ),
          onSendTap: onSendTap,
          chatViewState: ChatViewState.loading,
          // chatViewState: loading
          //     ? ChatViewState.loading
          //     : chatController.hasNoMessages
          //         ? ChatViewState.noData
          //         : hasError
          //             ? ChatViewState.error
          //             : ChatViewState.hasMessages,
          featureActiveConfig: const FeatureActiveConfig(
            enableSwipeToReply: true,
            enableSwipeToSeeTime: false,
            enableDoubleTapToLike: true,
            enableOtherUserProfileAvatar: true,
            enableCurrentUserProfileAvatar: true,
          ),
          sendMessageConfig: SendMessageConfiguration(
            replyMessageColor: weirdBlack75,
            replyDialogColor: faintBlue,
            replyTitleColor: weirdBlack,
            closeIconColor: weirdBlack,
            allowRecordingVoice: false,
            defaultSendButtonColor: appBlue,
            textFieldBackgroundColor: paleBlue,
            textFieldConfig: TextFieldConfiguration(
              textStyle: context.textTheme.bodyMedium!,
            ),
          ),
          chatBubbleConfig: ChatBubbleConfiguration(
            onDoubleTap: (message) {
              // Your code goes here
            },
            outgoingChatBubbleConfig: ChatBubble(
              color: appBlue,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              textStyle: context.textTheme.bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            inComingChatBubbleConfig: ChatBubble(
              color: faintBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              textStyle: context.textTheme.bodyMedium!
                  .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
            ),
          ),
          loadingWidget: blueLoader,
          chatViewStateConfig: ChatViewStateConfiguration(
            noMessageWidgetConfig: ChatViewStateWidgetConfiguration(
              title: "Oops! There are no messages here yet.",
              subTitle: "Send a message to start a conversation",
              titleTextStyle: context.textTheme.bodyLarge!.copyWith(
                color: weirdBlack,
                fontWeight: FontWeight.w600,
              ),
              reloadButton: Column(
                children: [
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => loading = true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBlue,
                      fixedSize: Size(100.w, 40.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: Text(
                      "Reload",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return SizedBox();
  }
}

class _InboxMenu extends StatefulWidget {
  const _InboxMenu();

  @override
  State<_InboxMenu> createState() => _InboxMenuState();
}

class _InboxMenuState extends State<_InboxMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: 414.w,
    );
  }
}

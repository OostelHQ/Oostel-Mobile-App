import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_hostel/api/base.dart';
import 'package:my_hostel/api/message_service.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/user.dart';
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
  ChatController? chatController;
  final List<Message> messageList = [];
  final List<ChatUser> users = [];

  late String currentUserID, otherUserID;

  bool loading = true, hasError = false;

  @override
  void initState() {
    super.initState();

    currentUserID = ref.read(currentUserProvider).id;
    otherUserID = widget.info.id;
    // initialize();

    sendMessage({
      "message": "Testing 123 again",
      "senderId": currentUserID,
      "receiverId": otherUserID,
    });
  }

  Future<void> initialize() async {
    late User? otherUser;
    if (widget.info.role == "Student") {
      otherUser = (await getStudentById(otherUserID)).payload;
    } else if (widget.info.role == "Landlord") {
      otherUser = (await getLandlordById(otherUserID)).payload;
      otherUser = (await getStudentById(widget.info.id)).payload;
    } else if (widget.info.role == "Landlord") {
      otherUser = (await getLandlordById(widget.info.id)).payload;
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

    users.add(ChatUser(
      id: currentUserID,
      name: ref.read(currentUserProvider).mergedNames,
      profilePhoto: ref.read(currentUserProvider).image,
    ));
    users.add(ChatUser(
      id: otherUserID,
      name: otherUser.mergedNames,
      profilePhoto: otherUser.image,
    ));

    getMessages({"senderId": currentUserID, "receiverId": otherUserID})
        .then((resp) {
      if (!resp.success) {
        showError(resp.message);
        if (!mounted) return;
        setState(() {
          loading = false;
          hasError = true;
        });
        return;
      }

      for (var element in resp.payload) {
        Message message = Message(
          message: element.content,
          createdAt: element.dateSent,
          sendBy: element.senderId,
          id: element.id,
        );
        messageList.add(message);
      }

      chatController = ChatController(
        initialMessageList: messageList,
        chatUsers: users,
        scrollController: ScrollController(),
      );

      if (!mounted) return;
      setState(() {
        loading = false;
        hasError = false;
      });
    });
  }

  @override
  void dispose() {
    chatController?.dispose();
    super.dispose();
  }

  void onSendTap(String rawMessage, ReplyMessage replyMessage,
      MessageType messageType) async {
    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      message: rawMessage,
      createdAt: DateTime.now(),
      sendBy: currentUserID,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    sendMessage({
      "message": rawMessage,
      "senderId": currentUserID,
      "receiverId": otherUserID,
    }).then((resp) {
      chatController?.addMessage(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: blueLoader)
          : hasError
              ? const Center()
              : SafeArea(
                  child: ChatView(
                    currentUser: users[0],
                    chatController: chatController!,
                    appBar: ChatViewAppBar(
                      elevation: 0.0,
                      leading: IconButton(
                        iconSize: 26.r,
                        splashRadius: 20.r,
                        icon: const Icon(Icons.chevron_left_rounded),
                        onPressed: () => context.router.pop(),
                      ),
                      profilePicture: "",
                      chatTitle: "John Doe",
                      userStatus: "Manchester Hostel",
                      chatTitleTextStyle: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      userStatusTextStyle:
                          context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                      backGroundColor: paleBlue,
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
                    chatViewState: ChatViewState.hasMessages,
                    // Add this state once data is available.
                    featureActiveConfig: const FeatureActiveConfig(
                      enableSwipeToReply: true,
                      enableSwipeToSeeTime: false,
                      enableDoubleTapToLike: true,
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
                        textStyle: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      inComingChatBubbleConfig: ChatBubble(
                        color: faintBlue,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        textStyle: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                    ),
                    loadingWidget: blueLoader,
                  ),
                ),
    );
  }
}

class _InboxMenu extends StatefulWidget {
  const _InboxMenu({super.key});

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

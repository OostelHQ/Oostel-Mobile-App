import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class Inbox extends ConsumerStatefulWidget {
  final String otherID;

  const Inbox({
    super.key,
    required this.otherID,
  });

  @override
  ConsumerState<Inbox> createState() => _InboxState();
}

class _InboxState extends ConsumerState<Inbox> {
  late ChatController chatController;
  late List<Message> messageList;
  late List<ChatUser> users;

  late String currentUserID;

  @override
  void initState() {
    super.initState();

    currentUserID = ref.read(currentUserProvider).id;

    users = [
      ChatUser(id: currentUserID, name: 'Me'),
      ChatUser(id: widget.otherID, name: 'Other'),
    ];

    messageList = [
      Message(
        id: '1',
        message: "Hi",
        createdAt: DateTime.now(),
        sendBy: users[0].id,
      ),
      Message(
        id: '2',
        message: "Hello",
        createdAt: DateTime.now(),
        sendBy: users[1].id,
      ),
    ];

    chatController = ChatController(
      initialMessageList: messageList,
      scrollController: ScrollController(),
      chatUsers: users,
    );
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  void onSendTap(String rawMessage, ReplyMessage replyMessage, MessageType messageType) {
    final message = Message(
      id: '3',
      message: rawMessage,
      createdAt: DateTime.now(),
      sendBy: currentUserID,
      replyMessage: replyMessage,
      messageType: messageType,
    );
    chatController.addMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChatView(
          currentUser: users[0],
          chatController: chatController,
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
            userStatusTextStyle: context.textTheme.bodyMedium!.copyWith(
              color: weirdBlack75,
              fontWeight: FontWeight.w500,
            ),
            backGroundColor: paleBlue,
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
                iconSize: 26.r,
                splashRadius: 20.r,
              )
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
          loadingWidget: loader,
        ),
      ),
    );
  }
}

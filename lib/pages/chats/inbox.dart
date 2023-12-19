import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:signalr_core/signalr_core.dart' as sc;

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

  late sc.HubConnection connection;

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

    connection = sc.HubConnectionBuilder()
        .withUrl(
            'https://fyndaapp-001-site1.htempurl.com/hubs/message',
            sc.HttpConnectionOptions(
              logging: (level, message) => log(message),
              transport: sc.HttpTransportType.webSockets,
            ))
        .build();
    openSignalRConnection();
  }

  //connect to signalR
  Future<void> openSignalRConnection() async {

    await connection.start();
    connection.on('ReceiveMessage', (message) {
      _handleIncomingDriverLocation(message);
    });

    //await connection.invoke('JoinUSer', args: [widget.userName, currentUserId]);
  }

//get messages
  Future<void> _handleIncomingDriverLocation(List<dynamic>? args) async {
    if (args != null) {}
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  // submitMessageFunction() async {
  //   var messageText = removeMessageExtraChar(messageTextController.text);
  //   await connection.invoke('SendMessage',
  //       args: [widget.userName, currentUserId, messageText]);
  //   messageTextController.text = "";
  //
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     chatListScrollController.animateTo(
  //       chatListScrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.ease,
  //     );
  //   });

  void onSendTap(String rawMessage, ReplyMessage replyMessage, MessageType messageType) async {
    final message = Message(
      id: '3',
      message: rawMessage,
      createdAt: DateTime.now(),
      sendBy: currentUserID,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    //await connection.invoke('SendMessage', args: [widget.userName, currentUserId, messageText]);
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
          loadingWidget: loader,
        ),
      ),
    );
  }
}

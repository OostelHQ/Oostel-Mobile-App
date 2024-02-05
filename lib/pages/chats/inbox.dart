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
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:signalr_core/signalr_core.dart' as sc;

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
  late List<Message> messageList;
  late List<ChatUser> users;

  late String currentUserID, otherUserID, currentUserEmail, otherUserEmail;
  late sc.HubConnection connection;

  bool loading = true, hasError = false;

  @override
  void initState() {
    super.initState();

    connection = sc.HubConnectionBuilder()
        .withUrl(
          '$baseEndpoint/hubs/message',
          sc.HttpConnectionOptions(
            logging: (level, message) => log(message),
            transport: sc.HttpTransportType.webSockets,
            accessTokenFactory: () async => token,
          ),
        )
        .build();

    //openSignalRConnection();
    initialize();

    currentUserID = otherUserEmail = currentUserEmail = otherUserID = "";
    users = [];
    messageList = [];
    chatController = ChatController(
      initialMessageList: messageList,
      chatUsers: users,
      scrollController: ScrollController(),
    );
  }

  Future<void> initialize() async {
    late User? otherUser;
    if (widget.info.role == "Student") {
      otherUser = (await getStudentById(widget.info.id)).payload;
    } else if (widget.info.role == "Landlord") {
      otherUser = (await getLandlordById(widget.info.id)).payload;
    } else {
      otherUser = (await getAgentById(widget.info.id)).payload;
    }

    if (otherUser == null) {
      setState(() {
        loading = false;
        hasError = true;
      });
      return;
    }

    User currentUser = ref.read(currentUserProvider);
    currentUserID = currentUser.id;
    currentUserEmail = currentUser.email;
    otherUserID = otherUser.id;
    otherUserEmail = otherUser.email;

    users = [
      ChatUser(
        id: currentUserID,
        name: currentUser.mergedNames,
        profilePhoto: currentUser.image,
      ),
      ChatUser(
        id: otherUserID,
        name: otherUser.mergedNames,
        profilePhoto: otherUser.image,
      ),
    ];

    // messageList = [];
    //
    // chatController = ChatController(
    //   initialMessageList: messageList,
    //   scrollController: ScrollController(),
    //   chatUsers: users,
    // );

    await openSignalRConnection();

    setState(() {});
  }

  Future<void> openSignalRConnection() async {
    await connection.start();

    connection.on('NewMessageReceived', (message) {
      _handleIncomingDriverLocation(message);
    });

    log("Current User ID: $currentUserID");
    log("Current User Email: $currentUserEmail");
    log("Other User ID: $otherUserID");
    log("Other User Email: $otherUserEmail");

    await connection.invoke(
      "SendMessage",
      args: [
        currentUserID,
        otherUserID,
        currentUserEmail,
        otherUserEmail,
        "This is a message"
      ],
    );
    //await connection.invoke('JoinUser', args: []);
  }

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

  void onSendTap(String rawMessage, ReplyMessage replyMessage,
      MessageType messageType) async {
    final message = Message(
      id: '3',
      message: rawMessage,
      createdAt: DateTime.now(),
      sendBy: currentUserID,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    await connection.invoke('SendMessage', args: [
      ref.read(currentUserProvider).id,
      users[1].id,
      ref.read(currentUserProvider).email,
      "student@gmail.com",
      rawMessage
    ]);

    chatController.addMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: blueLoader)
          : SafeArea(
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

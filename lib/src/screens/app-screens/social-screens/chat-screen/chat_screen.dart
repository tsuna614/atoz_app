import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/social-screens/chat-screen/message_bubble.dart';
import 'package:atoz_app/src/utils/custom_clip_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.targerUserData});

  final dynamic targerUserData;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();

  late var _currentUserId;
  late var _targetUserId;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text;

    final currentUserId =
        Provider.of<UserProvider>(context, listen: false).userId;
    final targetUserId = widget.targerUserData["userId"];

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    final db = FirebaseFirestore.instance;

    // look in the chat collection for a document that has a "users" map that contains both the current user and the target user's id
    db
        .collection("chat")
        .where("users.$currentUserId", isEqualTo: true)
        .where("users.$targetUserId", isEqualTo: true)
        .get()
        .then((value) {
      // if a document is found, add the message to the messages collection of that document
      if (value.docs.isNotEmpty) {
        db.collection("chat").doc(value.docs[0].id).collection("messages").add({
          "message": enteredMessage,
          "createdAt": Timestamp.now(),
          "userId": currentUserId,
        });
        // if no document was found, create new one, then add the message
      } else {
        db.collection("chat").add({
          "users": {
            currentUserId: true,
            targetUserId: true,
          },
        }).then((value) {
          db.collection("chat").doc(value.id).collection("messages").add({
            "message": enteredMessage,
            "createdAt": Timestamp.now(),
            "userId": currentUserId,
          });
        });
      }
    });

    // db.collection("abc").doc("adv").collection("collectionPath").

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    _currentUserId = Provider.of<UserProvider>(context, listen: false).userId;
    _targetUserId = widget.targerUserData["userId"];

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
            child: FutureBuilder(
                future: buildTextMessages(context),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No messages found.'),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong...'),
                    );
                  }

                  return snapshot.data!;
                }),
          ),
          ClipPath(
            clipper: AppBarClipPath(context: context, height: 1),
            child: Container(
              height: 120.0,
              decoration: BoxDecoration(
                // gradient
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blueAccent.shade200,
                    Colors.blue.shade700,
                  ],
                ),
                // color: Colors.transparent,
              ),
            ),
          ),
          buildAppBarNameCard(context),
          buildBottomTextArea(context),
        ],
      ),
    );
  }

  Widget buildAppBarNameCard(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(
                    'assets/images/avatar/${widget.targerUserData["profileImage"].toString()}.jpeg'),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  "${widget.targerUserData["firstName"]} ${widget.targerUserData["lastName"]}",
                  style: TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.ellipsisVertical),
                color: Colors.white,
              ),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Future<String> _getChatId() async {
    String chatId = "";

    await FirebaseFirestore.instance
        .collection("chat")
        .where("users.$_currentUserId", isEqualTo: true)
        .where("users.$_targetUserId", isEqualTo: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        chatId = value.docs[0].id;
      }
    });

    return chatId;
  }

  Future<Widget> buildTextMessages(BuildContext context) async {
    String chatId = "";
    chatId = await _getChatId();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .doc(chatId)
            .collection("messages")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, chatSnapshots) {
          print(chatId);
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('No messages found.'),
            );
          }

          if (chatSnapshots.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }

          final loadedMessages = chatSnapshots.data!.docs;

          return ListView.builder(
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (context, index) {
              final chatMessage = loadedMessages[index].data();

              return MessageBubble(
                message: chatMessage["message"],
                isCurrentUser: chatMessage["userId"] == _currentUserId,
              );
            },
          );
        });
  }

  Widget buildBottomTextArea(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _submitMessage();
              },
              icon: Icon(Icons.send),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

// return ListView(
          //   reverse: true,
          //   // physics: NeverScrollableScrollPhysics(),
          //   // crossAxisAlignment: CrossAxisAlignment.start,
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     MessageBubble(
          //       message:
          //           "So, i'm going the the cafe downtown this evening, join me if you want to",
          //       isCurrentUser: true,
          //     ),
          //     MessageBubble(
          //       message:
          //           "Oh really, I thought you were going to the gym every Thursday afternoon",
          //       isCurrentUser: false,
          //     ),
          //     MessageBubble(
          //       message:
          //           "Can't join you tho, stuck with that deadline at the office til 9pm, maybe next time",
          //       isCurrentUser: false,
          //     ),
          //     MessageBubble(
          //       message: "No worries, I'll catch you later then",
          //       isCurrentUser: true,
          //     ),
          //   ],
          // );
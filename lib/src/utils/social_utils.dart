import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/profile/spectate_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;

Future<bool> checkForExistingRequest(
    BuildContext context, String friendId) async {
  String userId = Provider.of<UserProvider>(context, listen: false).userId;
  bool isExisting = false;
  await FirebaseFirestore.instance
      .collection('notifications')
      .where('sender', isEqualTo: userId)
      .where('receiver', isEqualTo: friendId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      isExisting = true;
    }
  });
  return isExisting;
}

bool isUserAlreadyFriend(BuildContext context, String userId) {
  return Provider.of<UserProvider>(context, listen: false)
      .userFriends
      .contains(userId);
}

void cancelFriendRequest(BuildContext context, String friendId) {
  String userId = Provider.of<UserProvider>(context, listen: false).userId;

  FirebaseFirestore.instance
      .collection('notifications')
      .where('sender', isEqualTo: userId)
      .where('receiver', isEqualTo: friendId)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection('notifications')
          .doc(element.id)
          .delete();
    });
  });
}

void sendFriendRequest(BuildContext context, String friendId) {
  String userId = Provider.of<UserProvider>(context, listen: false).userId;

  FirebaseFirestore.instance.collection('notifications').add({
    'sender': userId,
    'receiver': friendId,
    'timeCreated': DateTime.now(),
  });
}

void unFriend(BuildContext context, String friendId) async {
  String currentUserId =
      Provider.of<UserProvider>(context, listen: false).userId;

  Provider.of<UserProvider>(context, listen: false)
      .userFriends
      .removeWhere((element) => element == friendId);

  Dio dio = Dio();
  await dio
      .put('${globals.atozApi}/user/removeFriend/$friendId/$currentUserId');
}

Future<void> showSocialPopUpMenu(
    BuildContext context, Offset globalPosition, dynamic userData) async {
  double left = globalPosition.dx;
  double top = globalPosition.dy;
  String currentUserId =
      Provider.of<UserProvider>(context, listen: false).userId;

  bool isFriendRequestExisted =
      await checkForExistingRequest(context, userData['userId']);

  if (context.mounted) {
    await showMenu(
      color: Colors.white,
      //add your color
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.circleUser),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "View profile",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          enabled: userData['userId'] == currentUserId ? false : true,
          value: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: [
                isFriendRequestExisted ||
                        isUserAlreadyFriend(context, userData['userId'])
                    ? Icon(Icons.person_remove_alt_1_outlined)
                    : Icon(Icons.person_add_alt_1_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  isFriendRequestExisted
                      ? "Cancel request"
                      : isUserAlreadyFriend(context, userData['userId'])
                          ? "Unfriend"
                          : "Send friend request",
                  style: TextStyle(
                    color: userData['userId'] == currentUserId
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          enabled: userData['userId'] == currentUserId ? false : true,
          value: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: [
                Icon(Icons.message),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Message",
                  style: TextStyle(
                      color: userData['userId'] == currentUserId
                          ? Colors.grey
                          : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 1) {
        // VIEWING PROFILE
        showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          // backgroundColor: Colors.transparent,
          builder: (context) => AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: MediaQuery.of(context).size.height * 1,
            child: Stack(
              children: [
                SpectateProfile(
                  userId: userData['userId'],
                  isDirectedFromLeaderboard: true,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      if (value == 2) {
        if (isFriendRequestExisted) {
          // CANCEL FRIEND REQUEST
          cancelFriendRequest(context, userData['userId']);
        } else if (isUserAlreadyFriend(context, userData['userId'])) {
          // UNFRIEND
          unFriend(context, userData['userId']);
        } else {
          // SEND FRIEND REQUEST
          sendFriendRequest(context, userData['userId']);
        }
      }
    });
  }
}

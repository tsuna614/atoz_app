import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/social/chat-screen/chat_screen.dart';
import 'package:atoz_app/src/utils/custom_clip_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;

enum UserStatus {
  active,
  away,
  doNotDisturb,
}

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  bool isSearchBarExtended = false;
  UserStatus userStatus = UserStatus.active;

  bool isNotificationOpen = false;

  bool hasNotification = false;

  List<dynamic> userFriendsData = [];

  final ValueNotifier<String> _notifier = ValueNotifier('');

  Future<dynamic> getUserData(String userId) async {
    Dio dio = Dio();
    Response response =
        await dio.get('${globals.atozApi}/user/getUserById/$userId');
    // setState(() {
    //   userData = response.data[0];
    // });
    // print(response.data[0]);
    return response.data[0];
  }

  void getAllUserFriendsData() async {
    for (int i = 0;
        i <
            Provider.of<UserProvider>(context, listen: false)
                .userFriends
                .length;
        i++) {
      userFriendsData.add(await getUserData(
          Provider.of<UserProvider>(context, listen: false).userFriends[i]));
    }
    setState(() {});
  }

  void addFriend(String senderId, String receiverId) {
    Dio dio = Dio();
    dio.put('${globals.atozApi}/user/addFriend/$senderId/$receiverId');
  }

  void removeNotification(String notificationId) {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .delete();
  }

  void changeUserState(String userState) {
    // Provider.of<UserProvider>(context, listen: false).setUserState(userState);

    switch (userState) {
      case "Active":
        userStatus = UserStatus.active;
        break;
      case "Busy":
        userStatus = UserStatus.doNotDisturb;
        break;
      case "Away":
        userStatus = UserStatus.away;
        break;
      default:
    }

    Dio dio = Dio();
    dio.put(
        '${globals.atozApi}/user/editUserById/${Provider.of<UserProvider>(context, listen: false).userId}',
        data: {'userState': userState});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUserFriendsData();
  }

  @override
  Widget build(BuildContext context) {
    String profileImagePath = context.watch<UserProvider>().profileImagePath;
    String userFullName =
        '${context.watch<UserProvider>().userFirstName} ${context.watch<UserProvider>().userLastName}';

    double xOffset = isNotificationOpen
        ? MediaQuery.of(context).size.width * 0.2
        : MediaQuery.of(context).size.width;
    double yOffset = 50;

    changeUserState(context.watch<UserProvider>().userState);

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: AppBarClipPath(context: context, height: 1),
                child: Container(
                  height: 194.0,
                  decoration: BoxDecoration(
                    // gradient
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueAccent.shade400,
                        Colors.blueAccent.shade100,
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        buildSearchBar(context),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // avatar
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: buildUserProfileAndStatus(
                          context, profileImagePath, userFullName),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    userFriendsData.isEmpty
                        ? Center(
                            child: Text(
                                'No friends yet. Get out there and make some!'))
                        : buildFriendList(context, userFriendsData),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            // when clicked on the blurred background, close the notification side drawer
            onTap: isNotificationOpen
                ? () {
                    setState(() {
                      isNotificationOpen = false;
                    });
                  }
                : null,

            child: isNotificationOpen
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5))
                : null,
          ),
          buildNotificationSideDrawer(context, xOffset, yOffset),
        ],
      ),
    );
  }

  final _searchBarController = TextEditingController();

  Widget buildUserProfileAndStatus(
      BuildContext context, String profileImagePath, String userFullName) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: profileImagePath.isEmpty
              ? AssetImage('assets/images/profile.jpg')
              : AssetImage('assets/images/avatar/$profileImagePath.jpeg'),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userFullName,
                style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: userStatus == UserStatus.active
                        ? Colors.greenAccent
                        : userStatus == UserStatus.away
                            ? Colors.orange
                            : Colors.red,
                    size: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    userStatus == UserStatus.active
                        ? 'Active now'
                        : userStatus == UserStatus.away
                            ? 'Away'
                            : 'Do not disturb',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      showPopUpMenu(context, details.globalPosition);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 80),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40,
            width: isSearchBarExtended
                ? MediaQuery.of(context).size.width * 1
                : 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearchBarExtended = !isSearchBarExtended;
                });
              },
            ),
          ),
          Positioned(
            top: 5,
            left: 50,
            right: 20,
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _searchBarController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search for friends',
                ),
                onChanged: (value) {
                  _notifier.value = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showPopUpMenu(
      BuildContext context, Offset globalPosition) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;

    await showMenu(
      elevation: 0,
      shadowColor: Colors.transparent,
      color: Colors.white.withOpacity(0.8),
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
                Icon(
                  Icons.circle,
                  color: Colors.greenAccent,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Active now",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Away",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Do not disturb",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      setState(() {
        if (value == 1) {
          context.read<UserProvider>().setUserState("Active");
          changeUserState("Active");
        } else if (value == 2) {
          context.read<UserProvider>().setUserState("Away");
          changeUserState("Away");
        } else if (value == 3) {
          context.read<UserProvider>().setUserState("Busy");
          changeUserState("Busy");
        }
      });
    });
  }

  Widget buildNotificationSideDrawer(
      BuildContext context, double xOffset, double yOffset) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .where('receiver', isEqualTo: context.watch<UserProvider>().userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // if (snapshot.data!.docs.isNotEmpty) {
        //   hasNotification = true;
        // }

        return SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isNotificationOpen = !isNotificationOpen;
                      });
                    },
                    icon: Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 26,
                        ),
                        if (snapshot.data!.docs.isNotEmpty)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 10,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                // on swipe right, close the notification side drawer
                onPanEnd: isNotificationOpen
                    ? (details) {
                        if (details.velocity.pixelsPerSecond.dx > 0) {
                          setState(() {
                            isNotificationOpen = false;
                          });
                        }
                      }
                    : null,
                child: AnimatedContainer(
                  transform: Matrix4.translationValues(xOffset, yOffset, 0)
                    ..scale(isNotificationOpen ? 1.00 : 1.00),
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                    // drop shadow to the right
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (snapshot.data!.docs.isEmpty)
                        Expanded(
                          child: Center(
                            child: Text('It\'s all quiet here...'),
                          ),
                        ),
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          // use FutureBuilder because ListView takes Widget, while we need to return Future<Widget>
                          return FutureBuilder(
                            future: getUserData(data['sender']),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return buildListTile(
                                  context,
                                  document.id,
                                  data['sender'],
                                  data['receiver'],
                                  snapshot.data);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildListTile(BuildContext context, String notificationId,
      String senderId, String receiverId, dynamic userData) {
    String userImage = "profile.jpg";
    if (userData["profileImage"] != null) {
      userImage = "avatar/${userData["profileImage"]}.jpeg";
    }

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/$userImage'),
          ),
          title: RichText(
              text: TextSpan(
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: userData['firstName'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' has sent you a friend request',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
        ),
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 7.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.green.shade400,
                    minimumSize: Size.fromHeight(25),
                  ),
                  onPressed: () {
                    addFriend(senderId, receiverId);
                    removeNotification(notificationId);
                    setState(() {});
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 14.0, left: 7.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.red,
                    minimumSize: Size.fromHeight(25),
                  ),
                  onPressed: () {
                    removeNotification(notificationId);
                  },
                  child: const Text(
                    'Decline',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        const Divider(
          height: 10,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }

  Widget buildFriendList(BuildContext context, List<dynamic> userFriendsData) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: userFriendsData.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: _notifier,
                  builder: ((context, value, child) {
                    String fullName =
                        '${userFriendsData[index]['firstName']} ${userFriendsData[index]['lastName']}';

                    if (fullName
                        .toLowerCase()
                        .contains(_notifier.value.toLowerCase())) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              targerUserData: userFriendsData[index],
                            ),
                          ));
                        },
                        child: ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: Image.asset(
                                        'assets/images/avatar/${userFriendsData[index]['profileImage']}.jpeg')
                                    .image,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.circle,
                                  color: userFriendsData[index]['userState'] ==
                                          "Active"
                                      ? Colors.greenAccent
                                      : userFriendsData[index]['userState'] ==
                                              "Away"
                                          ? Colors.orange
                                          : Colors.red,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            '${userFriendsData[index]['firstName']} ${userFriendsData[index]['lastName']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Row(
                            children: [
                              Text("Hello there"),
                              Expanded(child: Container()),
                              Text("2 days ago")
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

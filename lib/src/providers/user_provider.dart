import 'package:flutter/material.dart';

// final questionsProvider = Provider((ref) {
//   return dummyUser;
// });

class UserProvider extends ChangeNotifier {
  String userId = '';
  String userEmail = '';
  String userType = 'student';
  String userLanguage = 'English';
  int currentUserProgress = 0;
  int userScore = 0;
  int userProgressionPoint = 0;
  int userRanking = 1;
  int userAge = 0;

  String userFirstName = '';
  String userLastName = '';

  // profileImagePath: lion, tiger, penguin,...
  String profileImagePath = '';

  // user state: Active, Busy, Away
  String userState = '';

  // list of user's friends' id
  List<String> userFriends = [];

  bool isGameStart = false;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  void setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  void setCurrentUserProgress(int progress) {
    currentUserProgress = progress;
    notifyListeners();
  }

  void setUserScore(int point) {
    userScore = point;
    notifyListeners();
  }

  void setUserProgressionPoint(int point) {
    userProgressionPoint = point;
    notifyListeners();
  }

  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }

  void setUserLanguage(String language) {
    userLanguage = language;
    notifyListeners();
  }

  void setUserRanking(int ranking) {
    userRanking = ranking;
    notifyListeners();
  }

  void setUserFirstName(String firstName) {
    userFirstName = firstName;
    notifyListeners();
  }

  void setUserLastName(String lastName) {
    userLastName = lastName;
    notifyListeners();
  }

  void setProfileImage(String image) {
    profileImagePath = image;
    notifyListeners();
  }

  void setUserAge(int age) {
    userAge = age;
    notifyListeners();
  }

  void setUserFriends(List<dynamic> friends) {
    userFriends.clear();
    for (int i = 0; i < friends.length; i++) {
      // if the friend's id is not in userFriends yet, then add it in
      if (!userFriends.contains(friends[i].toString())) {
        userFriends.add(friends[i].toString());
      }
    }
    notifyListeners();
  }

  void setUserState(String state) {
    userState = state;
    notifyListeners();
  }

  void setGameStart(bool start) {
    isGameStart = start;
    notifyListeners();
  }
}

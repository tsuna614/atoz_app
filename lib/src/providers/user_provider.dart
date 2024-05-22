import 'package:atoz_app/src/models/chapter_model.dart';
import 'package:flutter/material.dart';

// final questionsProvider = Provider((ref) {
//   return dummyUser;
// });

class UserProvider extends ChangeNotifier {
  String userId = '';
  String userEmail = '';
  String userType = 'student';
  String userLanguage = 'English';
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

  // to get the total number of stages that the current user has cleared: currentUserProgress.length
  // to get the details of every stages in chapter 1: currentUserProgress[0]
  // to get the total number of stages in chapter 1: currentUserProgress[0].length (but default it is 10)
  List<List<StageDetails>> currentUserProgress = [];

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  void setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  void setUserCurrentProgress(List<List<dynamic>> progress) {
    // số 3 ở đây là số chapter code cứng tạm thời
    // vì mình chưa biết cách lấy chapters.length từ ChapterProvider (lol)
    for (int i = 0; i < 3; i++) {
      List<StageDetails> stages = [];
      if (i < progress.length) {
        for (int j = 0; j < progress[i].length; j++) {
          stages.add(StageDetails(
            star: progress[i][j]['star'],
            clearTime: progress[i][j]['clearTime'],
          ));
        }
      }
      currentUserProgress.add(stages);
    }
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
}

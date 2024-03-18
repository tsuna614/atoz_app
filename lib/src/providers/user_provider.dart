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

  String userFullName = '';
  String profileImagePath = '';

  // create UserProvider constructor

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

  void setUserFullName(String firstName, String lastName) {
    userFullName = '$firstName $lastName';
    notifyListeners();
  }

  void setProfileImage(String image) {
    profileImagePath = image;
    notifyListeners();
  }
}

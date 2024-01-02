import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final questionsProvider = Provider((ref) {
//   return dummyUser;
// });

class UserProvider extends ChangeNotifier {
  String userId = '';
  String userEmail = '';
  int currentUserProgress = 0;
  int userScore = 0;

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
}

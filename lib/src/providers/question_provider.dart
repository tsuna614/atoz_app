import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_connect_string.dart';
import 'package:flutter/material.dart';
// import 'package:atoz_app/src/data/questions.dart';

class QuestionProvider extends ChangeNotifier {
  // String language = 'English';

  List<List<QuizQuestion>> dummyEnglishQuizz = [
    [
      MultipleChoiceQuestion(
        question: 'How do you greet someone?',
        answers: ['Hello', 'Goodbye', 'Thank you', 'Sorry'],
        correctAnswer: 'Hello',
        imageAsset:
            'https://www.shutterstock.com/shutterstock/videos/1098377523/thumb/4.jpg?ip=x480',
      ),
      MultipleChoiceQuestion(
        question: 'Select the correct answer',
        answers: ['Hello', 'Good afternoon', 'Good morning', 'Good evening'],
        correctAnswer: 'Good morning',
        imageAsset:
            'https://st2.depositphotos.com/3745043/5334/v/950/depositphotos_53342633-stock-illustration-sunrise-at-early-morning-landscape.jpg',
      ),
      ReorderStringQuestion(
        question: 'Reorder the words to form a correct sentence',
        answers: [
          'Good morning',
          'Mike,',
          'how',
          'was',
          'your',
          'weekend?',
        ],
        correctAnswer: [
          'Good morning',
          'Mike,',
          'how',
          'was',
          'your',
          'weekend?',
        ],
        imageAsset:
            'https://img.freepik.com/free-vector/two-men-shake-hands-with-each-other-isolated-white-background-meeting-greeting-friends-businessmen-deal-agreement-illustration-partnership-cooperation-communication_575670-2344.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704067200&semt=ais',
      ),
      ConnectStringQuestion(
        question: 'Connect the words to form a correct sentence',
        leftAnswers: [
          'Good morning',
          'Good afternoon',
          'Good evening',
          'Good night',
        ],
        rightAnswers: [
          'Chào buổi sáng',
          'Chào buổi chiều',
          'Chào buổi tối',
          'Chúc ngủ ngon',
        ],
        correctAnswers: [
          'Good morning - Chào buổi sáng',
          'Good afternoon - Chào buổi chiều',
          'Good evening - Chào buổi tối',
          'Good night - Chúc ngủ ngon',
        ],
        imageAsset:
            'https://i.pinimg.com/474x/c3/d0/a4/c3d0a4c4fb0efd09fd6ea0f0c9d97c02.jpg',
      ),
      MultipleChoiceQuestion(
        question: 'Select the correct answer',
        answers: ['Hello', 'Good afternoon', 'Good morning', 'Good evening'],
        correctAnswer: 'Good evening',
        imageAsset:
            'https://i.pinimg.com/474x/c3/d0/a4/c3d0a4c4fb0efd09fd6ea0f0c9d97c02.jpg',
      ),
      MultipleChoiceQuestion(
        question: 'Select the correct answer',
        answers: ['Hello', 'Good afternoon', 'Good morning', 'Good evening'],
        correctAnswer: 'Good afternoon',
        imageAsset:
            'https://img.freepik.com/free-vector/gradient-tropical-sunset-background_52683-128662.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704153600&semt=ais',
      ),
    ],
  ];

  List<List<QuizQuestion>> dummyJapaneseQuizz = [
    [
      MultipleChoiceQuestion(
        question: 'How do you greet someone?',
        answers: ['こんにちは', 'さようなら', 'ありがとう', 'ごめん'],
        correctAnswer: 'こんにちは',
        imageAsset:
            'https://img.freepik.com/free-vector/two-men-shake-hands-with-each-other-isolated-white-background-meeting-greeting-friends-businessmen-deal-agreement-illustration-partnership-cooperation-communication_575670-2344.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704067200&semt=ais',
      ),
      MultipleChoiceQuestion(
        question: 'Select the correct answer',
        answers: ['こんにちは', 'ありがとう', 'おはよう', 'こんばんは'],
        correctAnswer: 'おはよう',
        imageAsset:
            'https://st2.depositphotos.com/3745043/5334/v/950/depositphotos_53342633-stock-illustration-sunrise-at-early-morning-landscape.jpg',
      ),
      MultipleChoiceQuestion(
        question: 'Select the correct answer',
        answers: ['こんにちは', 'ありがとう', 'おはよう', 'こんばんは'],
        correctAnswer: 'こんばんは',
        imageAsset:
            'https://i.pinimg.com/474x/c3/d0/a4/c3d0a4c4fb0efd09fd6ea0f0c9d97c02.jpg',
      ),
      MultipleChoiceQuestion(
        question: 'Select the correct answer',
        answers: ['こんにちは', 'ありがとう', 'おはよう', 'こんばんは'],
        correctAnswer: 'こんにちは',
        imageAsset:
            'https://img.freepik.com/free-vector/gradient-tropical-sunset-background_52683-128662.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704153600&semt=ais',
      ),
    ]
  ];
}

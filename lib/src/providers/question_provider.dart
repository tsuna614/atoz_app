import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:flutter/material.dart';
// import 'package:atoz_app/src/data/questions.dart';

class QuestionProvider extends ChangeNotifier {
  List<List<QuizQuestion>> dummyQuestionProvider = [
    [
      WordsDistributionQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Played',
          'Watched',
          'Seen',
          'Done',
          'Ploughed',
        ],
        correctAnswers1: [
          'Played',
          'Watched',
          'Saw',
          'Did',
          'Played',
          'Ploughed',
          // 'PlayedPlayedPlayedPlayed',
          // 'WatchedWatchedWatchedWatched',
          // 'SawSawSawSaw',
          // 'DidDidDidDid',
        ],
        correctAnswers2: [
          'Played',
          'Watched',
          'Seen',
          'Done',
          'Played',
          'Ploughed',
        ],
      ),
      TranslateQuestion(
        question: 'What is the name of this vehicle?',
        word: 'Train',
        correctAnswer: 'Train',
        imageAsset: 'assets/images/train.png',
        // imageAsset: '',
      ),
      ReorderStringQuestion(
        question: 'Re-order the words to make a meaningful sentence:',
        answers: [
          'Yesterday,',
          'I ate',
          'a',
          'lot',
          'of',
          'ice scream',
          'so',
          'I am',
          'having',
          'a stomachache',
        ],
        correctAnswer: [
          'Yesterday,',
          'I ate',
          'a',
          'lot',
          'of',
          'ice scream',
          'so',
          'I am',
          'having',
          'a stomachache',
        ],
        imageAsset: 'assets/images/japan.png',
      ),
      ConnectStringQuestion(
        question: 'Connect the words to its correct past tense:',
        leftAnswers: [
          'Go',
          'Eat',
          'Play',
          'Sleep',
        ],
        rightAnswers: [
          'Went',
          'Ate',
          'Played',
          'Slept',
        ],
        correctAnswers: [
          'Go - Went',
          'Eat - Ate',
          'Play - Played',
          'Sleep - Slept',
        ],
        imageAsset: 'assets/images/japan.png',
      ),
      MultipleChoiceQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Train',
          'Bus',
          'Plane',
          'Boat',
        ],
        correctAnswer: 'Plane',
        imageAsset: 'assets/images/plane.png',
      ),
    ],
    [
      MultipleChoiceQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Train',
          'Bus',
          'Plane',
          'Boat',
        ],
        correctAnswer: 'Train',
        imageAsset: 'assets/images/train.png',
      ),
      MultipleChoiceQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Train',
          'Bus',
          'Plane',
          'Boat',
        ],
        correctAnswer: 'Bus',
        imageAsset: 'assets/images/bus.png',
      ),
      MultipleChoiceQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Train',
          'Bus',
          'Plane',
          'Boat',
        ],
        correctAnswer: 'Boat',
        imageAsset: 'assets/images/boat.png',
      ),
      MultipleChoiceQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Train',
          'Bus',
          'Plane',
          'Boat',
        ],
        correctAnswer: 'Plane',
        imageAsset: 'assets/images/plane.png',
      ),
    ],
    [
      MultipleChoiceQuestion(
        question: 'What is the name of this vehicle?',
        answers: [
          'Train',
          'Bus',
          'Plane',
          'Boat',
        ],
        correctAnswer: 'Plane',
        imageAsset: 'assets/images/plane.png',
      ),
    ]
  ];
}

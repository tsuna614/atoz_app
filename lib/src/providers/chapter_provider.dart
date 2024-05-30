import 'package:atoz_app/src/models/chapter_model.dart';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:flutter/material.dart';

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
  [
    MultipleChoiceQuestion(
        question: 'Choose the correct answer',
        answers: ['Coffee', 'Water', 'Tea', 'Milk'],
        correctAnswer: 'Coffee',
        imageAsset:
            'https://static.vecteezy.com/system/resources/previews/013/860/284/original/hand-drawn-cartoon-coffee-with-beans-free-png.png'),
    // ReorderStringQuestion(
    //   question: 'Re-order the string to form a correct sentence',
    //   answers: ['Good morning.', 'Would', 'you', 'like', 'some', 'coffee?'],
    //   correctAnswer: [
    //     'Good morning.',
    //     'Would',
    //     'you',
    //     'like',
    //     'some',
    //     'coffee?'
    //   ],
    //   imageAsset:
    //       'https://www.shutterstock.com/image-photo/smiling-female-waitress-take-order-600nw-1492617746.jpg',
    // ),
    // TranslateQuestion(
    //   question: 'How do you greet someone in the morning?',
    //   word: '',
    //   correctAnswer: 'Good morning',
    //   imageAsset:
    //       'https://st2.depositphotos.com/3745043/5334/v/950/depositphotos_53342633-stock-illustration-sunrise-at-early-morning-landscape.jpg',
    // ),
    // MultipleChoiceQuestion(
    //   question: 'Choose the correct answer',
    //   answers: ['Coffee', 'Water', 'Tea', 'Milk'],
    //   correctAnswer: 'Milk',
    //   imageAsset: 'https://illustoon.com/photo/4920.png',
    // ),
    // ConnectStringQuestion(
    //   question: 'Connect the word to its meaning',
    //   leftAnswers: [
    //     'Coffee',
    //     'Water',
    //     'Tea',
    //     'Milk',
    //   ],
    //   rightAnswers: [
    //     'Cà phê',
    //     'Nước',
    //     'Trà',
    //     'Sữa',
    //   ],
    //   correctAnswers: [
    //     'Coffee - Cà phê',
    //     'Water - Nước',
    //     'Tea - Trà',
    //     'Milk - Sữa'
    //   ],
    //   imageAsset: '',
    // ),
  ],
  [
    WordsDistributionQuestion(
      question: 'Distribute the words into 2 groups',
      answers: [
        'Coffee',
        'Water',
        'Tea',
        'Milk',
        'Bread',
        'Rice',
        'Eggs',
        'Butter',
      ],
      group1Name: 'Drinks',
      group2Name: 'Foods',
      correctAnswers1: [
        'Coffee',
        'Water',
        'Tea',
        'Milk',
      ],
      correctAnswers2: [
        'Bread',
        'Rice',
        'Eggs',
        'Butter',
      ],
    ),
    ConnectStringQuestion(
      question: 'Connect the word to its meaning',
      leftAnswers: [
        'Coffee',
        'Water',
        'Tea',
        'Milk',
      ],
      rightAnswers: [
        'Cà phê',
        'Nước',
        'Trà',
        'Sữa',
      ],
      correctAnswers: [
        'Coffee - Cà phê',
        'Water - Nước',
        'Tea - Trà',
        'Milk - Sữa'
      ],
      imageAsset: '',
    ),
    DropDownQuestion(
      question: 'Choose the correct answer',
      sentencesList: [
        DropDownQuestionChild(
          sentence1: 'Yesterday I',
          sentence2: 'to school.',
          answers: ['went', 'go', 'goes', 'gone'],
          correctAnswer: 'went',
        ),
        DropDownQuestionChild(
          sentence1: 'I heard a noise downstairs. I',
          sentence2: 'check it out.',
          answers: ['am going to', 'will', 'going to', 'go'],
          correctAnswer: 'am going to',
        ),
        DropDownQuestionChild(
          sentence1: 'Marie',
          sentence2: 'to the cinema tomorrow, are you coming with her?',
          answers: ['will go', 'goes', 'is going', 'went'],
          correctAnswer: 'is going',
        ),
        DropDownQuestionChild(
          sentence1: 'Did you',
          sentence2: 'to do your homework?',
          answers: ['remember', 'remembers', 'remembered', 'will remember'],
          correctAnswer: 'remember',
        ),
      ],
    ),
    MultipleChoiceQuestion(
      question: 'Choose the correct answer',
      answers: ['Morning', 'Night', 'Afternoon', 'Evening'],
      correctAnswer: 'Evening',
      imageAsset:
          'https://img.freepik.com/free-vector/gradient-tropical-sunset-background_52683-128662.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704153600&semt=ais',
    ),
    ReorderStringQuestion(
      question: 'Re-order the string to form a correct sentence',
      answers: ['Good morning.', 'Would', 'you', 'like', 'some', 'coffee?'],
      correctAnswer: [
        'Good morning.',
        'Would',
        'you',
        'like',
        'some',
        'coffee?'
      ],
      imageAsset:
          'https://www.shutterstock.com/image-photo/smiling-female-waitress-take-order-600nw-1492617746.jpg',
    ),
    TranslateQuestion(
      question: 'How do you greet someone in the morning?',
      word: '',
      correctAnswer: 'Morning',
      imageAsset:
          'https://st2.depositphotos.com/3745043/5334/v/950/depositphotos_53342633-stock-illustration-sunrise-at-early-morning-landscape.jpg',
    ),
    ReadingQuestion(
      title: 'A summer day',
      paragraphsList: [
        'I am a student. I go to school every day. I study English, Math, Science, and Art. I like to play football with my friends. I also like to play video games. I have a dog. His name is Max. He is very cute. I love my dog.',
        'I am a student. I go to school every day. I study English, Math, Science, and Art. I like to play football with my friends. I also like to play video games. I have a dog. His name is Max. He is very cute. I love my dog.',
        'I am a student. I go to school every day. I study English, Math, Science, and Art. I like to play football with my friends. I also like to play video games. I have a dog. His name is Max. He is very cute. I love my dog.',
      ],
      questionsList: [
        ReadingMultipleChoiceQuestion(
          question: 'What is the name of this vehicle?',
          answers: [
            'Train',
            'Bus',
            'Plane',
            'Boat',
          ],
          correctAnswer: 'Train',
        ),
        ReadingMultipleChoiceQuestion(
          question: 'What is the name of this vehicle?',
          answers: [
            'Train',
            'Bus',
            'Plane',
            'Boat',
          ],
          correctAnswer: 'Bus',
        ),
        ReadingMultipleChoiceQuestion(
          question: 'What is the name of this vehicle?',
          answers: [
            'Train',
            'Bus',
            'Plane',
            'Boat',
          ],
          correctAnswer: 'Plane',
        ),
        ReadingMultipleChoiceQuestion(
          question: 'What is the name of this vehicle?',
          answers: [
            'Train',
            'Bus',
            'Plane',
            'Boat',
          ],
          correctAnswer: 'Boat',
        ),
      ],
    ),
  ],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
];

class ChapterProvider extends ChangeNotifier {
  List<Chapter> chapters = [
    Chapter(
      chapterName: 'GREETINGS',
      stages: [
        Stage(questions: dummyEnglishQuizz[0], stageIndex: 0),
        Stage(questions: dummyEnglishQuizz[1], stageIndex: 1),
        Stage(questions: dummyEnglishQuizz[2], stageIndex: 2),
        Stage(questions: dummyEnglishQuizz[3], stageIndex: 3),
        Stage(questions: dummyEnglishQuizz[4], stageIndex: 4),
        Stage(questions: dummyEnglishQuizz[5], stageIndex: 5),
        Stage(questions: dummyEnglishQuizz[6], stageIndex: 6),
        Stage(questions: dummyEnglishQuizz[7], stageIndex: 7),
        Stage(questions: dummyEnglishQuizz[8], stageIndex: 8),
        Stage(questions: dummyEnglishQuizz[9], stageIndex: 9),
      ],
    ),
    Chapter(
      chapterName: 'TRAVEL',
      stages: [
        Stage(questions: dummyEnglishQuizz[10], stageIndex: 0),
        Stage(questions: dummyEnglishQuizz[11], stageIndex: 1),
        Stage(questions: dummyEnglishQuizz[12], stageIndex: 2),
        Stage(questions: dummyEnglishQuizz[13], stageIndex: 3),
        Stage(questions: dummyEnglishQuizz[14], stageIndex: 4),
        Stage(questions: dummyEnglishQuizz[15], stageIndex: 5),
        Stage(questions: dummyEnglishQuizz[16], stageIndex: 6),
        Stage(questions: dummyEnglishQuizz[17], stageIndex: 7),
        Stage(questions: dummyEnglishQuizz[18], stageIndex: 8),
        Stage(questions: dummyEnglishQuizz[19], stageIndex: 9),
      ],
    ),
    Chapter(
      chapterName: 'FOOD',
      stages: [
        Stage(questions: dummyEnglishQuizz[20], stageIndex: 0),
        Stage(questions: dummyEnglishQuizz[21], stageIndex: 1),
        Stage(questions: dummyEnglishQuizz[22], stageIndex: 2),
        Stage(questions: dummyEnglishQuizz[23], stageIndex: 3),
        Stage(questions: dummyEnglishQuizz[24], stageIndex: 4),
        Stage(questions: dummyEnglishQuizz[25], stageIndex: 5),
        Stage(questions: dummyEnglishQuizz[26], stageIndex: 6),
        Stage(questions: dummyEnglishQuizz[27], stageIndex: 7),
        Stage(questions: dummyEnglishQuizz[28], stageIndex: 8),
        Stage(questions: dummyEnglishQuizz[29], stageIndex: 9),
      ],
    ),
  ];
}

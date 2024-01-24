import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:flutter/material.dart';
// import 'package:atoz_app/src/data/questions.dart';

class QuestionProvider extends ChangeNotifier {
  // String language = 'English';

  List<QuizQuestion> dummyWritingQuizz = [
    DropDownQuestion(
      question: 'Select the correct answer for each sentence.',
      sentencesList: [
        DropDownQuestionChild(
          sentence1: 'Yesterday, I',
          sentence2: 'to school at 8 AM.',
          answers: ['Go', 'Went', 'Gone', 'Is going'],
          correctAnswer: 'Went',
        ),
        DropDownQuestionChild(
          sentence1: '',
          sentence2: 'I known about the news, I wouldn\'t have come',
          answers: ['Had', 'Have', 'Hadn\'t', 'Having'],
          correctAnswer: 'Had',
        ),
        DropDownQuestionChild(
          sentence1: 'I',
          sentence2: 'to the cinema tomorrow, are you coming with me?',
          answers: ['Go', 'Goes', 'Going', 'Will go'],
          correctAnswer: 'Will go',
        ),
        DropDownQuestionChild(
          sentence1: 'This job',
          sentence2: 'at least 2 people.',
          answers: ['Required', 'Requires', 'Require', 'Requiring'],
          correctAnswer: 'Requires',
        ),
        DropDownQuestionChild(
          sentence1: 'Jack,',
          sentence2: 'to do your homework okay?',
          answers: ['Remember', 'Remembered', 'Remembering', 'Will remember'],
          correctAnswer: 'Remember',
        ),
      ],
    ),
  ];

  List<QuizQuestion> dummyTestQuizz = [
    MultipleChoiceQuestion(
        question: 'Choose the correct answer',
        answers: ['Coffee', 'Water', 'Tea', 'Milk'],
        correctAnswer: 'Coffee',
        imageAsset:
            'https://static.vecteezy.com/system/resources/previews/013/860/284/original/hand-drawn-cartoon-coffee-with-beans-free-png.png'),
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
      correctAnswer: 'Good morning',
      imageAsset:
          'https://st2.depositphotos.com/3745043/5334/v/950/depositphotos_53342633-stock-illustration-sunrise-at-early-morning-landscape.jpg',
    ),
    MultipleChoiceQuestion(
      question: 'Choose the correct answer',
      answers: ['Coffee', 'Water', 'Tea', 'Milk'],
      correctAnswer: 'Milk',
      imageAsset: 'https://illustoon.com/photo/4920.png',
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
    ReadingQuestion(
      title: 'My next summer holiday plan',
      paragraphsList: [
        "I usually teach English at a language school in the summer. I often can’t enjoy the summer because I am so busy. So this summer, I’m not planning to work. Instead, I’m going to have a proper summer holiday. I’m going to buy a campervan and drive around Ireland. I’m going to visit lots of beautiful beaches and learn to surf! I’m mostly going to travel alone, but I will visit friends. One friend, Cathy, is a school teacher, so she has a long summer holiday, so hopefully, we will spend a week or two together. Another Irish friend, Joe, has a new house there, so I’ll stay with him for a few days and help him paint the rooms.",
        "Last year, I did a surfing instructor course, and I spent the summer teaching people to surf. It was great! I was in the sea and sun all day, and every evening, my friends and I had a barbecue on the beach. The surf school asked me to return this summer, but I’m not going to do that. Last autumn, I learned to scuba dive, and I’m going to do a diving instructor course soon. Then, I plan to teach diving all summer to earn some money. I don’t want to stay in the UK. It’s too cold here! I want to fly to Greece or Egypt. I’ll go there alone. I’m sure I will meet lots of cool people there!",
        "Well, last month, my friend Alfie and I had a crazy idea. We decided to cycle from the south of England to the north of Scotland, from Land’s End to John o’Groats. It’s an 874-mile trip! It takes ten to fourteen days. But I’m not a fast cyclist, and I want to enjoy visiting different places, so we plan to ride for four weeks. We will visit historic cities like Bath and Edinburgh, cycle through the pretty countryside and visit museums and castles on the way. Alfie wanted to camp, but I’d like a comfortable bed at the end of each day, so we are going to stay in guest houses. I hope it doesn’t rain a lot, but I hope it’s not too hot either!",
      ],
      questionsList: [
        ReadingMultipleChoiceQuestion(
          question: 'Which person is going to work this summer?',
          answers: [
            'Emma',
            'Jayden',
            'Pamela',
          ],
          correctAnswer: 'Emma',
        ),
        ReadingMultipleChoiceQuestion(
          question: 'Which person is going to stay in the UK?',
          answers: [
            'Emma',
            'Jayden',
            'Pamela',
          ],
          correctAnswer: 'Jayden',
        ),
        ReadingMultipleChoiceQuestion(
          question:
              "Which person wants to learn a new sport during the summer?",
          answers: [
            'Emma',
            'Jayden',
            'Pamela',
          ],
          correctAnswer: 'Pamela',
        ),
      ],
    ),
  ];

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
        correctAnswer: 'Good morning',
        imageAsset:
            'https://st2.depositphotos.com/3745043/5334/v/950/depositphotos_53342633-stock-illustration-sunrise-at-early-morning-landscape.jpg',
      ),
      MultipleChoiceQuestion(
        question: 'Choose the correct answer',
        answers: ['Coffee', 'Water', 'Tea', 'Milk'],
        correctAnswer: 'Milk',
        imageAsset: 'https://illustoon.com/photo/4920.png',
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
    ],
    [
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
  ];
}

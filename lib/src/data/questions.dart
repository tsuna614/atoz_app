import '../models/quiz_question.dart';

final List<QuizQuestion> dummyQuestions = [
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
  MultipleChoiceQuestion(
    question: 'What are the main building blocks of Flutter UIs?',
    answers: [
      'Widgets',
      'Components',
      'Blocks',
      'Functions',
    ],
    correctAnswer: 'Widgets',
    imageAsset: 'assets/images/train.png',
  ),
  MultipleChoiceQuestion(
    question: 'How are Flutter UIs built?',
    answers: [
      'By combining widgets in code',
      'By combining widgets in a visual editor',
      'By defining widgets in config files',
      'By using XCode for iOS and Android Studio for Android',
    ],
    correctAnswer: 'By combining widgets in code',
    imageAsset: 'assets/images/train.png',
  ),
  MultipleChoiceQuestion(
    question: 'What is the purpose of a StatefulWidget?',
    answers: [
      'Update UI as data changes',
      'Update data as UI changes',
      'Ignore data changes',
      'Render UI that does not depend on data',
    ],
    correctAnswer: 'Update UI as data changes',
    imageAsset: 'assets/images/train.png',
  ),
  MultipleChoiceQuestion(
    question:
        'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    answers: [
      'StatelessWidget',
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
    correctAnswer: 'StatelessWidget',
    imageAsset: 'assets/images/train.png',
  ),
  MultipleChoiceQuestion(
    question: 'What happens if you change data in a StatelessWidget?',
    answers: [
      'The UI is not updated',
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
    correctAnswer: 'The UI is not updated',
    imageAsset: 'assets/images/train.png',
  ),
  MultipleChoiceQuestion(
    question: 'How should you update data inside of StatefulWidgets?',
    answers: [
      'By calling setState()',
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
    correctAnswer: 'By calling setState()',
    imageAsset: 'assets/images/train.png',
  ),
];

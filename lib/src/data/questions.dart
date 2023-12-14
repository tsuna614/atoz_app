import '../models/quiz_question.dart';

const dummyQuestions = [
  QuizQuestion(
    'Re-order the words to make a meaningful sentence:',
    [
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
    'Train',
    'assets/images/japan.png',
  ),
  QuizQuestion(
    'What is the name of this vehicle?',
    [
      'Train',
      'Bus',
      'Plane',
      'Boat',
    ],
    'Train',
    'assets/images/train.png',
  ),
  QuizQuestion(
    'What are the main building blocks of Flutter UIs?',
    [
      'Widgets',
      'Components',
      'Blocks',
      'Functions',
    ],
    'Widgets',
    'assets/images/train.png',
  ),
  QuizQuestion(
    'How are Flutter UIs built?',
    [
      'By combining widgets in code',
      'By combining widgets in a visual editor',
      'By defining widgets in config files',
      'By using XCode for iOS and Android Studio for Android',
    ],
    'By combining widgets in code',
    'assets/images/train.png',
  ),
  QuizQuestion(
    'What\'s the purpose of a StatefulWidget?',
    [
      'Update UI as data changes',
      'Update data as UI changes',
      'Ignore data changes',
      'Render UI that does not depend on data',
    ],
    'Update UI as data changes',
    'assets/images/train.png',
  ),
  QuizQuestion(
    'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    [
      'StatelessWidget',
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
    'StatelessWidget',
    'assets/images/train.png',
  ),
  QuizQuestion(
    'What happens if you change data in a StatelessWidget?',
    [
      'The UI is not updated',
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
    'The UI is not updated',
    'assets/images/train.png',
  ),
  QuizQuestion(
    'How should you update data inside of StatefulWidgets?',
    [
      'By calling setState()',
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
    'By calling setState()',
    'assets/images/train.png',
  ),
];

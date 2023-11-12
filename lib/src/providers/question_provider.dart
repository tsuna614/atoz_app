import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atoz_app/src/data/questions.dart';

final questionsProvider = Provider((ref) {
  return dummyQuestions;
});

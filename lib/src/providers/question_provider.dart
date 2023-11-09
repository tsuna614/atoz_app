import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atoz_app/src/data/questions.dart';

final mealsProvider = Provider((ref) {
  return dummyQuestions;
});

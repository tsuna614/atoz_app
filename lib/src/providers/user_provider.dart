import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atoz_app/src/data/dummy_user.dart';

final questionsProvider = Provider((ref) {
  return dummyUser;
});

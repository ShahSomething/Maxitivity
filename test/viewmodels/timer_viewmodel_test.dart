import 'package:flutter_test/flutter_test.dart';
import 'package:maxitivity/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TimerViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

library restlib.testing_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/objects.dart";
import "package:restlib_testing/testing.dart";

part "src/equals_tester_test.dart";

testingTestGroups() {
  group("class EqualsTester", equalsTesterTests);
}

main() {
  testingTestGroups();
}
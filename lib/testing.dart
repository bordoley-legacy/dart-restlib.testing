library restlib.testing;

import "dart:async";

import "package:unittest/matcher.dart" as matcher;
import "package:unittest/unittest.dart" as unittest;

import "package:restlib_common/objects.dart";

part "src/equals_tester.dart";

void expectOnCompletion(final Future f, onComplete(dynamic)) =>
    unittest.expect(f.then(onComplete), matcher.completes);
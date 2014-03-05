part of testing.collections;

abstract class BiMapTester {
  Iterable<int> get testSizes;

  void _doBiMapTest(final String testDescription, func(BiMap testData, int size)) =>
      group(testDescription, () =>
          testSizes.forEach((final int size) =>
              test("with BiMap of size $size", () =>
                  func(generateTestData(size), size))));

  dynamic generateTestData(int size);

  void testGetInverse(final BiMap testData, final int size) {
    final BiMap inverse = testData.inverse;
    testData.forEach((final Pair pair) =>
        expect(inverse[pair.e1].value, equals(pair.e0)));
  }

  void testBiMap() {
    checkNotNull(testSizes);

    _doBiMapTest("get inverse", testGetInverse);
  }
}


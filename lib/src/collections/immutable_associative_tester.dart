part of testing.collections;

abstract class ImmutableAssociativeTester {
  int get insertCount;
  int get insertAllCount;
  PairGenerator get pairGenerator;
  int get removeAtCount;

  dynamic generateTestData(int size);

  void testPut() {
    ImmutableAssociative assoc = generateTestData(0);

    pairGenerator.reset();

    for (int i = 0; i < insertCount; i++) {
      final Pair next = pairGenerator.next();

      expect(assoc[next.e0], isEmpty);
      assoc = assoc.put(next.e0, next.e1);
      expect(assoc[next.e0].contains(next.e1), isTrue);
    }
  }

  void testPutAll() {
    ImmutableAssociative assoc = generateTestData(0);

    pairGenerator.reset();

    Array<Pair> array = new Array.ofSize(insertAllCount);

    for (int i = 0; i < insertAllCount; i++) {
      final Pair next = pairGenerator.next();
      array[i] = next;
    }

    assoc = assoc.putAll(array);
    array.forEach((final Pair pair) =>
        expect(assoc[pair.e0].contains(pair.e1), isTrue));
  }

  void testPutPair() {
    ImmutableAssociative assoc = generateTestData(0);

    pairGenerator.reset();

    for (int i = 0; i < insertCount; i++) {
      final Pair next = pairGenerator.next();

      expect(assoc[next.e0], isEmpty);
      assoc = assoc.putPair(next);
      expect(assoc[next.e0].contains(next.e1), isTrue);
    }
  }

  void testRemoveAt() {
    ImmutableAssociative assoc = generateTestData(0);

    pairGenerator.reset();
    for (int i = 0; i < removeAtCount; i++) {
      assoc = assoc.putPair(pairGenerator.next());
    }

    while (assoc.keys.isNotEmpty) {
      final key = assoc.keys.first;
      final value = assoc[key].first;

      assoc = assoc.removeAt(key);

      expect(assoc[key].contains(value), isFalse);
    }
  }

  void testImmutableAssociative() {
    checkNotNull(insertCount);
    checkNotNull(insertAllCount);
    checkNotNull(pairGenerator);
    checkNotNull(removeAtCount);

    test("put()", testPut);
    test("putAll()", testPutAll);
    test("putPair()", testPutPair);
    test("removeAt()", testRemoveAt);
  }
}
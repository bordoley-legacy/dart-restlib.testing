part of testing.collections;

class ImmutableStackTester
    extends Object
    with IterableTester,
      StackTester {

  Iterable<int> testSizes;
  dynamic generator;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutabletStack() {
    checkNotNull(generator);
    
    testIterable();
    testStack();
  }
}
part of restlib.testing;

class IterableTester<T> {
  Iterable<T> empty;

  Iterable<T> mappedSingleItr;
  dynamic mapFunc;
  
  dynamic other;
  
  Iterable<T> singleItr;
  T singleValue;
  
  IterableTester();
  
  test() {
    checkState(empty != null);
    checkState(singleItr != null);
    checkState(mappedSingleItr != null);
    checkState(mapFunc != null);
    checkState(singleValue != other);
    
    unittest.group("get first", () {
      unittest.test("with empty", () => 
          unittest.expect(() => empty.first, unittest.throwsStateError));
      unittest.test("with single", () => 
          unittest.expect(singleItr.first, unittest.equals(singleValue)));
    });
    
    unittest.group("get isEmpty", () {
      unittest.test("with empty", () => 
          unittest.expect(empty.isEmpty, unittest.isTrue));
      unittest.test("with single", () => 
          unittest.expect(singleItr.isEmpty, unittest.isFalse));
    });
    
    unittest.group("get length", () {
      unittest.test("with empty", () => 
          unittest.expect(empty.length, unittest.equals(0)));
      unittest.test("with single", () => 
          unittest.expect(singleItr.length, unittest.equals(1)));
    });
    
    unittest.group("get single", () {
      unittest.test("with empty", () => 
          unittest.expect(() => empty.single, unittest.throwsStateError));
      unittest.test("with single", () => 
          unittest.expect(singleItr.single, unittest.equals(singleValue)));
    });
    
    unittest.group("any()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.any((e) => true), unittest.isFalse)); 
      unittest.test("with single", () {
        unittest.expect(singleItr.any((e) => true), unittest.isTrue);
        unittest.expect(singleItr.any((e) => false), unittest.isFalse);
      });     
    });
  
    unittest.group("contains()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.contains(new Object()), unittest.isFalse)); 
      unittest.test("with single", () {
        unittest.expect(singleItr.contains(singleValue), unittest.isTrue);
        unittest.expect(singleItr.contains(other), unittest.isFalse);
      });     
    });
    
    unittest.group("elementAt()", () {
      unittest.test("with empty", () =>
          unittest.expect(() => empty.elementAt(0), unittest.throwsRangeError)); 
      unittest.test("with single", () {
        unittest.expect(singleItr.elementAt(0), unittest.equals(singleValue));
        unittest.expect(() => singleItr.elementAt(1), unittest.throwsRangeError);
      });     
    });
    
    unittest.group("every()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.every((e) => true), unittest.isTrue)); 
      unittest.test("with single", () {
        unittest.expect(singleItr.every((e) => true), unittest.isTrue);
        unittest.expect(singleItr.every((e) => false), unittest.isFalse);
      });     
    });
    
    unittest.group("expand()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.expand((e) => [1,2,3]), unittest.equals(empty))); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.expand((e) => [1,2,3]), unittest.equals([1,2,3])));   
    });
    
    unittest.group("firstWhere()", () {
      unittest.test("with empty", () {
        unittest.expect(() => empty.firstWhere((e) => true), unittest.throwsStateError); 
        unittest.expect(empty.firstWhere((e) => true, orElse: () => 1), unittest.equals(1));
      });
      unittest.test("with single", () {
        unittest.expect(singleItr.firstWhere((e) => true), unittest.equals(singleValue));
        unittest.expect(() => singleItr.firstWhere((e) => false), unittest.throwsStateError);    
        unittest.expect(singleItr.firstWhere((e) => true, orElse: () => 2), unittest.equals(singleValue));
        unittest.expect(singleItr.firstWhere((e) => false, orElse: () => other), unittest.equals(other));
      });     
    });
    
    unittest.group("fold()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.fold(1, (a, b) => a + b), unittest.equals(1))); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.fold(1, (a, b) => other), unittest.equals(other)));     
    });
    
    unittest.group("forEach()", () {
      unittest.test("with empty", () {
        bool foreach = false;
        empty.forEach((e) => foreach = true);
        unittest.expect(foreach, unittest.isFalse);
      }); 
      unittest.test("with single", () {
        bool foreach = false;
        singleItr.forEach((e){ foreach = true; });
        unittest.expect(foreach, unittest.isTrue);
      });     
    });
    
    unittest.group("join()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.join(), unittest.equals(""))); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.join(), unittest.equals(singleValue.toString())));     
    });
    
    unittest.group("lastWhere()", () {
      unittest.test("with empty", () {
        unittest.expect(() => empty.lastWhere((e) => true), unittest.throwsStateError);
        unittest.expect(empty.lastWhere((e) => true, orElse: () => 1), unittest.equals(1));
      }); 
      unittest.test("with single", () {
        unittest.expect(singleItr.lastWhere((e) => true), unittest.equals(singleValue));
        unittest.expect(() => singleItr.lastWhere((e) => false), unittest.throwsStateError);  
        unittest.expect(singleItr.lastWhere((e) => true, orElse: () => null), unittest.equals(singleValue));
      });     
    });
    
    unittest.group("map()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.map((e) => e), unittest.equals(empty))); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.map(mapFunc), unittest.equals(mappedSingleItr)));     
    });
    
    unittest.group("reduce()", () {
      unittest.test("with empty", () =>
          unittest.expect(() => empty.reduce((a, b) => a + b), unittest.throwsStateError)); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.reduce((a, b) => other), unittest.equals(singleValue)));     
    });
    
    unittest.group("singleWhere()", () {
      unittest.test("with empty", () =>
          unittest.expect(() => empty.singleWhere((e) => true), unittest.throwsStateError)); 
      unittest.test("with single", () {
        unittest.expect(singleItr.singleWhere((e) => true), unittest.equals(singleValue));
        unittest.expect(() => singleItr.singleWhere((e) => false), unittest.throwsStateError);
      });     
    });
    
    unittest.group("skip()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.skip(0), unittest.equals(empty))); 
      unittest.test("with single", () {
        unittest.expect(singleItr.skip(0), unittest.equals(singleItr));
        unittest.expect(singleItr.skip(1), unittest.equals(empty));
      });     
    });
    
    unittest.group("skipWhile()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.skipWhile((e) => false), unittest.equals(empty))); 
      unittest.test("with single", () {
        unittest.expect(singleItr.skipWhile((e) => false), unittest.equals(singleItr));
        unittest.expect(singleItr.skipWhile((e) => true), unittest.equals(empty));
      });     
    });
    
    unittest.group("take()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.take(0), unittest.equals(empty))); 
      unittest.test("with single", () {
        unittest.expect(singleItr.take(0), unittest.equals(empty));
        unittest.expect(singleItr.take(1), unittest.equals(singleItr));
      });     
    });
    
    unittest.group("takeWhile()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.takeWhile((e) => false), unittest.equals(empty))); 
      unittest.test("with single", () {
        unittest.expect(singleItr.takeWhile((e) => false), unittest.equals(empty));
        unittest.expect(singleItr.takeWhile((e) => true), unittest.equals(singleItr));
      });     
    });
    
    unittest.group("toList()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.toList(), unittest.isEmpty)); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.toList(), unittest.equals([singleValue])));     
    });
    
    unittest.group("toSet()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.toSet(), unittest.isEmpty)); 
      unittest.test("with single", () =>
          unittest.expect(singleItr.toSet(), unittest.equals([singleValue].toSet())));     
    });
    
    unittest.group("where()", () {
      unittest.test("with empty", () =>
          unittest.expect(empty.where((e) => true), unittest.equals(empty))); 
      unittest.test("with single", () {
        unittest.expect(singleItr.where((e) => false), unittest.equals(empty));
        unittest.expect(singleItr.where((e) => true), unittest.equals(singleItr));
      });     
    });
  }
}


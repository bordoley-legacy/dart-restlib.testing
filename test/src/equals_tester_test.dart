part of restlib.testing_test;

equalsTesterTests() {
  test("equal objects are equal.", () =>
    new EqualsTester()
      ..addEqualityGroup(
          [new _ValidTestObject(1,2), new _ValidTestObject(1,2), new _ValidTestObject(1,2)])
      ..testEquals());
  
  test("equal objects are equal, not equal objects are unequal.", () =>
    new EqualsTester() 
      ..addEqualityGroup(
          [new _ValidTestObject(1,2), new _ValidTestObject(1,2), new _ValidTestObject(1,2)])
      ..addEqualityGroup(
          [new _ValidTestObject(2,3), new _ValidTestObject(2,3), new _ValidTestObject(2,3)])
      ..testEquals());
  
  test("class with invalid hashCode implementation.", () =>
    expect(() =>
        new EqualsTester()
          ..addEqualityGroup(
              [new _InvalidHashCodeObject(1,2), new _InvalidHashCodeObject(1,2), new _InvalidHashCodeObject(1,2)])
          ..testEquals(), throws));
  
  test("with unequal objects in equality group.", ()  =>
    expect(() => 
        new EqualsTester()
          ..addEqualityGroup([new _ValidTestObject(1,2), new _ValidTestObject(3,4)])
          ..testEquals(), throws));
  
  test("non-reflexive equals.", () =>
    expect(()=> 
        new EqualsTester()
          ..addEqualityGroup([new _NonReflexiveObject()])
          ..testEquals(), throws));
  
  test("invalid, object equals null.", () =>
    expect(() => 
        new EqualsTester()
          ..addEqualityGroup([new _InvalidEqualsNullObject()])
          ..testEquals(), throws));
  
  test("object implements invalid equals against incompatible class.", () =>
      expect(() =>
          new EqualsTester()
            ..addEqualityGroup(new _InvalidEqualsIncompatibleClassObject()), throws));
  
  test("symmetry broken.", () => 
      expect(() => 
          new EqualsTester()
            ..addEqualityGroup([new _NamedObject("foo").addPeers("bar"), new _NamedObject("bar")])
            ..testEquals(), throws));
  
  test("transitivity broken within an equality group.", () => 
      expect(() => 
          new EqualsTester()
            ..addEqualityGroup(
                [new _NamedObject("foo").addPeers("bar", "baz"),
                 new _NamedObject("bar").addPeers("foo"),
                 new _NamedObject("baz").addPeers("foo")])
            ..testEquals(), throws));
  
  test("transitivity broken across equality groups.", () =>
      expect(() => 
          new EqualsTester()
            ..addEqualityGroup(
                [new _NamedObject("foo").addPeers("bar"),
                 new _NamedObject("bar").addPeers("foo", "x")])
            ..addEqualityGroup(
                [new _NamedObject("baz").addPeers("x"),
                 new _NamedObject("x").addPeers("baz", "bar")])
            ..testEquals(), throws));
}

class _ValidTestObject {
  final int _aspect1;
  final int _aspect2;
  final int hashCode;
  
  _ValidTestObject(aspect1, aspect2) :
    this._aspect1 = aspect1,
    this._aspect2 = aspect2,
    this.hashCode = computeHashCode([aspect1, aspect2]);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is _ValidTestObject) {
      _ValidTestObject that = other;
      return this._aspect1 == that._aspect1 && 
          this._aspect2 == that._aspect2;
    } else {
      return false;
    }
  }
}

class _InvalidHashCodeObject {
  final int _aspect1;
  final int _aspect2;
  
  _InvalidHashCodeObject(aspect1, aspect2) :
    this._aspect1 = aspect1,
    this._aspect2 = aspect2;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is _ValidTestObject) {
      _ValidTestObject that = other;
      return this._aspect1 == that._aspect1 && 
          this._aspect2 == that._aspect2;
    } else {
      return false;
    }
  }
}

class _InvalidEqualsIncompatibleClassObject{
  final int hashCode = 0;
  
  bool operator==(other) {
    if (other == null) {
      return false;
    }
    return true;
  }
}

class _InvalidEqualsNullObject{
  final int hashCode = 0;
  
  bool operator==(other) {
    return other == this || other == null;
  }
}

class _NamedObject {
  final Set<String> _peerNames = new Set();
  final String _name;
  final int hashCode = 0;

  _NamedObject(this._name);

  addPeers(List<String> names) {
    _peerNames.addAll(names);
    return this;
  }

  bool operator==(other) {
    if (other is _NamedObject) {
      _NamedObject that = other;
      return _name == that._name || _peerNames.contains(that._name);
    }
    return false;
  }

  String toString() {
    return _name;
  }
}

class _NonReflexiveObject{
  bool operator ==(other) {
    return false;
  }
}
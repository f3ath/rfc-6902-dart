/// Tests values for "deep" equality.
/// Maps and Lists are equal when they have same keys and the corresponding values are "deep" equal.
/// Other objects are compared using "==".
bool deepEqual(a, b) {
  if (a == b) return true;
  if (a is Map && b is Map) {
    return a.length == b.length &&
        a.entries
            .every((e) => b.containsKey(e.key) && deepEqual(e.value, b[e.key]));
  }
  if (a is List && b is List) {
    return deepEqual(a.asMap(), b.asMap());
  }
  return false;
}

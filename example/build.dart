import 'dart:convert';

import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/rfc_6902.dart';

void main() {
  final patch = JsonPatch.build([
    Test(JsonPointer('/a/b/c'), 'foo'),
    Remove(JsonPointer('/a/b/c')),
    Add(JsonPointer('/a/b/c'), ['foo', 'bar']),
    Replace(JsonPointer('/a/b/c'), 42),
    Move(JsonPointer('/a/b/c'), JsonPointer('/a/b/d')),
    Copy(JsonPointer('/a/b/d'), JsonPointer('/a/b/e')),
  ]);
  print(jsonEncode(patch));
  // [
  //  {"op":"test","path":"/a/b/c","value":"foo"},
  //  {"op":"remove","path":"/a/b/c"},
  //  {"op":"add","path":"/a/b/c","value":["foo","bar"]},
  //  {"op":"replace","path":"/a/b/c","value":42},
  //  {"op":"move","from":"/a/b/c","path":"/a/b/d"},
  //  {"op":"copy","from":"/a/b/d","path":"/a/b/e"}
  // ]
}

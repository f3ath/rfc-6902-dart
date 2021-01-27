import 'dart:convert';

import 'package:rfc_6902/rfc_6902.dart';

void main() {
  final patch = JsonPatch.build([
    Test('/a/b/c', 'foo'),
    Remove('/a/b/c'),
    Add('/a/b/c', ['foo', 'bar']),
    Replace('/a/b/c', 42),
    Move('/a/b/c', '/a/b/d'),
    Copy('/a/b/d', '/a/b/e'),
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

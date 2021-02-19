# [RFC 6902] JSON Patch
JSON Patch ([RFC 6902]) implementation in Dart.

## Building and encoding to JSON
```dart
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
}
```
produces
```
[
    {"op":"test","path":"/a/b/c","value":"foo"},
    {"op":"remove","path":"/a/b/c"},
    {"op":"add","path":"/a/b/c","value":["foo","bar"]},
    {"op":"replace","path":"/a/b/c","value":42},
    {"op":"move","from":"/a/b/c","path":"/a/b/d"},
    {"op":"copy","from":"/a/b/d","path":"/a/b/e"}
]
```

## Parsing JSON and applying to the document
```dart
import 'dart:convert';

import 'package:rfc_6902/rfc_6902.dart';

void main() {
  const document = {
    'a': {
      'b': {'c': 'foo'}
    }
  };
  const json = '''
   [
     { "op": "test", "path": "/a/b/c", "value": "foo" },
     { "op": "remove", "path": "/a/b/c" },
     { "op": "add", "path": "/a/b/c", "value": [ "foo", "bar" ] },
     { "op": "replace", "path": "/a/b/c", "value": 42 },
     { "op": "move", "from": "/a/b/c", "path": "/a/b/d" },
     { "op": "copy", "from": "/a/b/d", "path": "/a/b/e" }
   ]
  ''';
  final patch = JsonPatch(jsonDecode(json));
  final result = patch.applyTo(document);
  print(result); // {a: {b: {d: 42, e: 42}}}
}
```

[RFC 6902]: https://tools.ietf.org/html/rfc6902
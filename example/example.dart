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

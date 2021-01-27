import 'dart:convert';
import 'dart:io';

import 'package:rfc_6902/rfc_6902.dart';
import 'package:test/test.dart';

void main() {
  group('JSON encoding', () {
    test('Empty encodes into []', () {
      expect(jsonEncode(JsonPatch()), '[]');
    });
    test('Non-empty encodes in itself', () {
      final json = jsonDecode(File('test/example.json').readAsStringSync());
      final patch = JsonPatch(json);
      expect(jsonDecode(jsonEncode(patch)), equals(json));
    });
  });
}

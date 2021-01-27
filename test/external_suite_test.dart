import 'dart:convert';
import 'dart:io';

import 'package:rfc_6902/rfc_6902.dart';
import 'package:test/test.dart';

void main() {
  final List suite =
      jsonDecode(File('external/test-suite/tests.json').readAsStringSync());
  const skip = {85: 'Duplicate keys are removed by Dart'};
  group('External Test Suite', () {
    suite.asMap().entries.forEach((entry) {
      final id = entry.key;
      final testCase = entry.value;
      final comment = testCase['comment'];
      final document = testCase['doc'];
      final payload = testCase['patch'];
      final expected = testCase['expected'];
      final error = testCase['error'];
      final description = comment != null ? '($id) $comment' : '($id)';
      test(description, () {
        if (expected != null) {
          expect(JsonPatch(payload).applyTo(document), equals(expected));
        }
        if (error != null) {
          expect(() => JsonPatch(payload).applyTo(document), throwsException);
        }
      }, skip: skip[id]);
    });
  });
}

import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/rfc_6902.dart';
import 'package:test/test.dart';

void main() {
  group('Failures', () {
    test('Exception contains a "test" failure', () {
      final addOp = Add('/foo', 42);
      final testOp = Test('/foo', false);
      final patch = JsonPatch.build([addOp, testOp]);
      expect(
          () => patch.applyTo({}),
          throwsA(predicate((e) =>
              e is OperationFailure &&
              e.operation == testOp &&
              e.reason == null)));
    });
    test('Exception contains an "add" failure', () {
      final addOp = Add('/foo/bar', 42);
      final patch = JsonPatch.build([addOp]);
      expect(
          () => patch.applyTo({}),
          throwsA(predicate((e) =>
              e is OperationFailure &&
              e.operation == addOp &&
              e.reason is BadRoute)));
    });
  });
}

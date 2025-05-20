import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/rfc_6902.dart';
import 'package:test/test.dart';

void main() {
  group('Failures', () {
    test('Exception contains a "test" failure', () {
      final addOp = Add(JsonPointer('/foo'), 42);
      final testOp = Test(JsonPointer('/foo'), false);
      final patch = JsonPatch.build([addOp, testOp]);

      expect(
        () => patch.applyTo({}),
        throwsA(
          isA<OperationFailure>()
              .having((e) => e.operation, 'operation', testOp)
              .having((e) => e.reason, 'reason', null)
              .having(
                (e) => e.toString(),
                'toString',
                'OperationFailure: Failed to perform `Test` at path `/foo`',
              ),
        ),
      );
    });

    test('Exception contains an "add" failure', () {
      final addOp = Add(JsonPointer('/foo/bar'), 42);
      final patch = JsonPatch.build([addOp]);
      expect(
        () => patch.applyTo({}),
        throwsA(
          isA<OperationFailure>()
              .having((e) => e.operation, 'operation', addOp)
              .having((e) => e.reason, 'reason', isA<BadRoute>())
              .having(
                (e) => e.toString(),
                'toString',
                'OperationFailure: Failed to perform `Add` at path `/foo/bar` - No value found at /foo',
              ),
        ),
      );
    });
  });
}

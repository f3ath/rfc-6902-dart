import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/rfc_6902.dart';
import 'package:test/test.dart';

void main() {
  group('Order Preservation', () {
    test('Map key order is preserved after replace operation', () {
      final map = {'a': 1, 'b': 2, 'c': 3};

      final replaceOp = Replace(JsonPointer('/a'), 4);
      final patch = JsonPatch.build([replaceOp]);
      final result = patch.applyTo(map) as Map;
      expect(result.keys.toList(), equals(['a', 'b', 'c']));
    });
  });
}

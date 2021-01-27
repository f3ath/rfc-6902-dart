import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/deep_equal.dart';
import 'package:rfc_6902/src/operation.dart';
import 'package:rfc_6902/src/operation_failure.dart';

/// The "test" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.6
class Test implements Operation {
  Test(String path, value) : this.build(JsonPointer(path), value);

  Test.build(this.path, this.value);

  static const name = 'test';

  final JsonPointer path;

  final Object? value;

  @override
  Object? apply(Object? document) {
    if (!deepEqual(path.read(document), value)) throw OperationFailure(this);
    return document;
  }

  @override
  Map toJson() => {
        'op': name,
        'path': path.toString(),
        'value': value,
      };
}

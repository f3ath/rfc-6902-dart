import 'package:rfc_6902/src/encoded_operation.dart';
import 'package:rfc_6902/src/operations/add.dart';
import 'package:rfc_6902/src/operations/copy.dart';
import 'package:rfc_6902/src/operations/move.dart';
import 'package:rfc_6902/src/operations/remove.dart';
import 'package:rfc_6902/src/operations/replace.dart';
import 'package:rfc_6902/src/operations/test.dart';

/// JSON Patch operation
abstract class Operation {
  /// Creates a new Operation object from [json].
  factory Operation(Map json) {
    final encoded = EncodedOperation(json);
    return _factory[encoded.op]?.call(encoded) ??
        (throw FormatException('Invalid operation "${encoded.op}"'));
  }

  static final _factory = <String, Operation Function(EncodedOperation _)>{
    Add.name: (_) => Add(_.path, _.value),
    Copy.name: (_) => Copy(_.from, _.path),
    Move.name: (_) => Move(_.from, _.path),
    Test.name: (_) => Test(_.path, _.value),
    Remove.name: (_) => Remove(_.path),
    Replace.name: (_) => Replace(_.path, _.value),
  };

  /// Applies the operation to the [document].
  /// Returns modified document.
  Object? apply(Object? document);

  /// Converts the operation to a JSON-encodable [Map].
  Map toJson();
}

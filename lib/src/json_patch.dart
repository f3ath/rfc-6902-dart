import 'dart:collection';

import 'package:rfc_6902/src/operation.dart';
import 'package:rfc_6902/src/operation_failure.dart';

/// JSON Patch document
class JsonPatch with IterableMixin<Operation> {
  /// Creates a new instance from JSON array.
  JsonPatch([List json = const []])
      : this.build(json.map((op) => Operation(op)));

  /// Creates a new instance with the [operations].
  JsonPatch.build(Iterable<Operation> operations) {
    _operations.addAll(operations);
  }

  /// The patch operations
  final _operations = <Operation>[];

  /// Returns a copy of the [document] with all operations applied sequentially.
  /// Throws [OperationFailure] if any operation fails.
  Object? applyTo(document) => fold(document, (doc, op) {
        try {
          return op.apply(doc);
        } on OperationFailure {
          rethrow;
        } catch (e) {
          throw OperationFailure(op, reason: e);
        }
      });

  List toJson() => map((op) => op.toJson()).toList();

  @override
  Iterator<Operation> get iterator => _operations.iterator;
}

import 'package:rfc_6902/src/operation.dart';

class OperationFailure implements Exception {
  OperationFailure(this.operation, {this.reason});

  /// The operation which failed.
  final Operation operation;

  /// The nested exception which caused failure.
  final Object? reason;
}

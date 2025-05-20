import 'package:rfc_6902/src/operation.dart';

class OperationFailure implements Exception {
  const OperationFailure(this.operation, {this.reason});

  /// The operation which failed.
  final Operation operation;

  /// The nested exception which caused failure.
  final Object? reason;

  @override
  String toString() {
    final buffer = StringBuffer('OperationFailure: ');
    buffer.write(
      'Failed to perform `${operation.runtimeType}` at path `${operation.path}`',
    );
    if (reason != null) buffer.write(' - $reason');
    return buffer.toString();
  }
}

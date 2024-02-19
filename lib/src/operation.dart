import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/deep_equal.dart';
import 'package:rfc_6902/src/operation_failure.dart';

/// JSON Patch operation
sealed class Operation {
  /// Applies the operation to the [document].
  /// Returns modified document.
  Object? apply(Object? document);

  /// Converts the operation to a JSON-encodable [Map].
  Map toJson();
}

/// The "add" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.1
class Add implements Operation {
  Add(this.path, this.value);

  static const name = 'add';

  final JsonPointer path;

  final Object? value;

  @override
  Object? apply(Object? document) => path.add(document, value);

  @override
  Map toJson() => {
        'op': name,
        'path': path.toString(),
        'value': value,
      };
}

/// The "copy" operation
///
/// https://tools.ietf.org/html/rfc6902#section-4.5
class Copy implements Operation {
  Copy(this.from, this.path);

  static const name = 'copy';

  final JsonPointer from;

  final JsonPointer path;

  @override
  Object? apply(Object? document) => path.add(document, from.read(document));

  @override
  Map toJson() => {
        'op': name,
        'from': from.toString(),
        'path': path.toString(),
      };
}

/// The "move" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.4
class Move implements Operation {
  Move(this.from, this.path);

  static const name = 'move';

  final JsonPointer from;

  final JsonPointer path;

  @override
  Object? apply(Object? document) {
    final value = from.read(document);
    return path.add(from.remove(document), value);
  }

  @override
  Map toJson() => {
        'op': name,
        'from': from.toString(),
        'path': path.toString(),
      };
}

/// The "remove" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.2
class Remove implements Operation {
  Remove(this.path);

  static const name = 'remove';

  final JsonPointer path;

  @override
  Object? apply(Object? document) => path.remove(document);

  @override
  Map toJson() => {
        'op': name,
        'path': path.toString(),
      };
}

/// The "replace" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.3
class Replace implements Operation {
  Replace(this.path, this.value);

  static const name = 'replace';

  final JsonPointer path;

  final Object? value;

  @override
  Object? apply(Object? document) => path.add(path.remove(document), value);

  @override
  Map toJson() => {
        'op': name,
        'path': path.toString(),
        'value': value,
      };
}

/// The "test" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.6
class Test implements Operation {
  Test(this.path, this.value);

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

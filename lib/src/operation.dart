import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/deep_equal.dart';
import 'package:rfc_6902/src/operation_failure.dart';

/// JSON Patch operation
sealed class Operation {
  const Operation(this.path);

  final JsonPointer path;

  /// Applies the operation to the [document].
  /// Returns modified document.
  Object? apply(Object? document);

  /// Converts the operation to a JSON-encodable [Map].
  Map toJson();
}

/// The "add" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.1
class Add extends Operation {
  const Add(super.path, this.value);

  static const name = 'add';

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
class Copy extends Operation {
  const Copy(this.from, super.path);

  static const name = 'copy';

  final JsonPointer from;

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
class Move extends Operation {
  const Move(this.from, super.path);

  static const name = 'move';

  final JsonPointer from;

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
class Remove extends Operation {
  const Remove(super.path);

  static const name = 'remove';

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
class Replace extends Operation {
  const Replace(super.path, this.value);

  static const name = 'replace';

  final Object? value;

  @override
  Object? apply(Object? document) {
    // Unlike `path.write`, `path.read` will throw if the path does not exist.
    path.read(document);
    return path.write(document, value);
  }

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
class Test extends Operation {
  const Test(super.path, this.value);

  static const name = 'test';

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

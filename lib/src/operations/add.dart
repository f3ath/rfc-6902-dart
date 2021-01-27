import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/operation.dart';

/// The "add" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.1
class Add implements Operation {
  Add(String path, value) : this.build(JsonPointer(path), value);

   Add.build(this.path, this.value);

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

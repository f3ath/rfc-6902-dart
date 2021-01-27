import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/operation.dart';

/// The "replace" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.3
class Replace implements Operation {
  Replace(String path, value) : this.build(JsonPointer(path), value);

  const Replace.build(this.path, this.value);

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

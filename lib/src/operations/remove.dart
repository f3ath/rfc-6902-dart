import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/operation.dart';

/// The "remove" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.2
class Remove implements Operation {
  Remove(String path) : this.build(JsonPointer(path));

  Remove.build(this.path);

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

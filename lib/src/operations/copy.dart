import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/operation.dart';

/// The "copy" operation
///
/// https://tools.ietf.org/html/rfc6902#section-4.5
class Copy implements Operation {
  Copy(String from, String path)
      : this.build(JsonPointer(from), JsonPointer(path));

  Copy.build(this.from, this.path);

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

import 'package:rfc_6901/rfc_6901.dart';
import 'package:rfc_6902/src/operation.dart';

/// The "move" operation.
///
/// https://tools.ietf.org/html/rfc6902#section-4.4
class Move implements Operation {
  Move(String from, String path)
      : this.build(JsonPointer(from), JsonPointer(path));

  Move.build(this.from, this.path);

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

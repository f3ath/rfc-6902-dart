import 'package:rfc_6901/rfc_6901.dart';

/// JSON-encoded operation
class EncodedOperation {
  EncodedOperation(this._json);

  /// JSON object
  final Map _json;

  JsonPointer get path => JsonPointer(_get<String>('path'));

  JsonPointer get from => JsonPointer(_get<String>('from'));

  String get op => _get<String>('op');

  Object? get value => _get('value');

  T _get<T>(String key) {
    if (_json.containsKey(key)) {
      final val = _json[key];
      if (val is T) return val;
    }
    throw const FormatException();
  }
}

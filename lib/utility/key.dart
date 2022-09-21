import 'dart:convert';
import 'dart:typed_data';

class Key {
  final Uint8List? bytes;
  final bool isPublic;

  Key(this.bytes) : isPublic = false;

  Key.withPublicBytes(this.bytes) : isPublic = true;

  @override
  int get hashCode => bytes!.length;

  @override
  operator ==(other) {
    if (other is Key) {
      return byteListEqual(bytes!, other.bytes!);
    }
    return false;
  }

  @override
  String toString() {
    if (isPublic) {
      return "Key('${toBase64()}')";
    }
    return "Key('some bytes)";
  }

  static Key fromBase64({required String encoded, bool isPublic = false}) {
    final bytes = base64.decode(encoded);
    if (isPublic) {
      return Key.withPublicBytes(bytes);
    }
    return Key(bytes);
  }

  String toBase64() {
    return base64.encode(bytes!);
  }

  static bool byteListEqual(List<int> left, List<int> right) {
    if (left.length != right.length) {
      return false;
    }
    var result = true;
    for (var i = 0; i < left.length; i++) {
      if (left[i] != right[i]) {
        result = false;
      }
    }
    return result;
  }
}

class AsymmetricKeyPair {
  final Key publicKey;
  final Key secretKey;

  AsymmetricKeyPair({required this.secretKey, required this.publicKey})
      // ignore: unnecessary_null_comparison
      : assert(secretKey != null),
        // ignore: unnecessary_null_comparison
        assert(publicKey != null);

  @override
  int get hashCode => publicKey.hashCode;

  @override
  operator ==(other) =>
      other is AsymmetricKeyPair &&
      secretKey == other.secretKey &&
      publicKey == other.publicKey;
}

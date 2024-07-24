import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart';

class Security {
  final key = Key.fromUtf8('z2esbnvI3BcqgtNdtHnVLJqoWOkspk4j');
  final key2 = 'z2esbnvI3BcqgtNdtHnVLJqoWOkspk4j';
  final iv = 'Lg4DywUwUuaoVWVS';

  final keyBackend = Key.fromUtf8('1234567876543221246543765454re34');
  final keyBackend2 = '1234567876543221246543765454re34';
  final ivBackend = '1234567876543221';

  String encryptAES(String plainText) {
    final ivUint8 = Uint8List.fromList(iv.codeUnits);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: IV(ivUint8));
    return encrypted.base64;
  }

  String decryptAES(String encryptedText) {
    final ivUint8 = Uint8List.fromList(ivBackend.codeUnits);
    final desencrypter = Encrypter(AES(keyBackend, mode: AESMode.cbc));
    final encrypted = Encrypted.fromBase64(encryptedText);
    final decrypted = desencrypter.decrypt(encrypted, iv: IV(ivUint8));
    return decrypted;
  }

  String aesDecryption(String input) {
    final keyBytes = utf8.encode(keyBackend2.substring(0, 32));
    final ivBytes = utf8.encode(ivBackend.substring(0, 16));
    final inputBytes = hex.decode(input);

    final params = PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
      ParametersWithIV<KeyParameter>(KeyParameter(Uint8List.fromList(keyBytes)), Uint8List.fromList(ivBytes)),
      null,
    );

    final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(false, params);

    try {
      final decrypted = cipher.process(Uint8List.fromList(inputBytes));
      return utf8.decode(decrypted);
    } on ArgumentError catch (e) {
      throw StateError('Failed to decrypt the input data: $e');
    }
  }

  String aesEncryption(String input) {
    final keyBytes = Uint8List.fromList(key2.codeUnits.sublist(0, 32));
    final ivBytes = Uint8List.fromList(iv.codeUnits.sublist(0, 16));
    final inputBytes = utf8.encode(input);

    final params = PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
      ParametersWithIV<KeyParameter>(KeyParameter(keyBytes), ivBytes),
      null,
    );

    final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(true, params);

    try {
      final encrypted = cipher.process(Uint8List.fromList(inputBytes));
      return hex.encode(encrypted);
    } on ArgumentError catch (e) {
      throw StateError('Failed to encrypt the input data: $e');
    }
  }
}
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  // A static secure key. In a production vault, you would ideally derive this 
  // from the user's master password using PBKDF2 or store it securely in the Keystore/Keychain.
  // For this implementation, a strong static 32-byte key is used.
  static final _key = encrypt.Key.fromUtf8('c0deL0ckV@ult!S3cur3K3y#2026A3S+'); // 32 chars
  static final _iv = encrypt.IV.fromLength(16);

  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key, mode: encrypt.AESMode.cbc));

  /// Encrypts plain text. If the input is null or empty, returns the original input.
  static String? encryptText(String? plainText) {
    if (plainText == null || plainText.isEmpty) {
      return plainText;
    }
    try {
      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      // In case of error, return original text to prevent data loss.
      return plainText;
    }
  }

  /// Decrypts encrypted text. If decryption fails (e.g., old unencrypted data),
  /// it gracefully returns the original string to maintain backwards compatibility.
  static String? decryptText(String? encryptedText) {
    if (encryptedText == null || encryptedText.isEmpty) {
      return encryptedText;
    }
    try {
      final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
      return decrypted;
    } catch (e) {
      // If it throws an exception (like Invalid base64 or wrong padding),
      // it means the text was likely saved before encryption was introduced.
      // So we return the original unencrypted text.
      return encryptedText;
    }
  }
}

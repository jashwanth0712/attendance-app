import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();

// Function to get a value from secure storage.
Future<String?> getValueFromSecureStorage(String key) async {
  try {
    return await _storage.read(key: key);
  } catch (e) {
    print('Error while reading from secure storage: $e');
    return null;
  }
}

// Function to set a value in secure storage.
Future<void> setValueInSecureStorage(String key, String value) async {
  try {
    await _storage.write(key: key, value: value);
    print('Value saved to secure storage successfully.');
  } catch (e) {
    print('Error while saving to secure storage: $e');
  }
}

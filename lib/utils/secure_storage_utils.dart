import 'dart:convert';

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
Future<List<Map<String, dynamic>>?> getDataValueFromSecureStorage(String key) async {
  try {
    final jsonData = await _storage.read(key: key);
    if (jsonData != null && jsonData.isNotEmpty) {
      return List<Map<String, dynamic>>.from(jsonDecode(jsonData));
    }
    return null;
  } catch (e) {
    print('Error while reading from secure storage: $e');
    return null;
  }
}
// Function to set a value in secure storage.
Future<void> setValueInSecureStorage(String key, String value) async {
  try {
    await _storage.write(key: key, value: value);
    print('Value $key and $value saved to secure storage successfully.');
  } catch (e) {
    print('Error while saving to secure storage: $e');
  }
}

Future<void> setDataValueInSecureStorage(String key, dynamic value) async {
  try {
    String jsonString = jsonEncode(value); // Convert the JSON object to a string
    await _storage.write(key: key, value: jsonString);
    print('Value saved to secure storage successfully.');
  } catch (e) {
    print('Error while saving to secure storage: $e');
  }
}
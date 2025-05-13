import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>?> loadFromFile(String path) async {
  try {
    final dir = Directory.current;
    final jsonStr = await File('${dir.path}\\$path').readAsString();
    return jsonDecode(jsonStr) as Map<String, dynamic>;
  } catch (e) {
    return null;
  }
}
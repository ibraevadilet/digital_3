import 'package:shared_preferences/shared_preferences.dart';

class LocalLikedPostsRepository {
  static const String key = 'likedPosts';
  static Future<List<String>> getLikedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<void> setLikedPost(String categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    final localList = prefs.getStringList(key) ?? [];
    localList.add(categoryId);
    prefs.setStringList(key, localList);
  }

  static Future<void> deleteLikedPost(String categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    final localList = prefs.getStringList(key) ?? [];
    localList.remove(categoryId);
    prefs.setStringList(key, localList);
  }

  static Future<void> dispose() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

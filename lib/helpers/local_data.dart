import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userId);
}

Future<void> setUserName(String userName) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', userName);
}

Future<String> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId') ?? '21131';
}

Future<String> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName') ?? 'Adilet';
}

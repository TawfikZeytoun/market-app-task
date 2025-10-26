import 'dart:convert';
import 'package:market_app/features/cart/data/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static String _cartKey(String username) => 'cart_$username';

  static Future<void> saveCartForUser(CartModel cart, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey(username), jsonEncode(cart.toJson()));
  }

  static Future<CartModel?> getCartForUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cartKey(username));
    return raw == null ? null : CartModel.fromJson(jsonDecode(raw));
  }

  static Future<void> clearCartForUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey(username));
  }


  static const String _usernameKey = 'username';
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'userId';

  static Future<void> saveUserCredentials(String username, String token, [int? userId]) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_tokenKey, token);
    if (userId != null) await prefs.setInt(_userIdKey, userId);
  }
static Future<String?> getUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_usernameKey);
}

  static Future<String?> getToken() async => (await SharedPreferences.getInstance()).getString(_tokenKey);
  static Future<int?> getUserId() async => (await SharedPreferences.getInstance()).getInt(_userIdKey);

  static Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
  }
}
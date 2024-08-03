import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_movie_app/models/account/account.dart';

class SharedPref {
  /*
  getter
  */
  Future<String?> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('accounts');
    return jsonString;
  }

  Future<Account?> getAccountLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('account_login');

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return Account.fromJson(json);
    }
  }

  Future<bool> getIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('is_login');
    return value ?? false;
  }

  /*
  setter
  */
  Future<void> setAccount(String jsonString) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accounts', jsonString);
  }

  Future<void> setAccountLogin(Account? account) async {
    final prefs = await SharedPreferences.getInstance();

    if (account != null) {
      final jsonString = jsonEncode(account.toJson());
      await prefs.setString('account_login', jsonString);
    } else {
      await prefs.remove('account_login');
    }
  }

  Future<void> setIsLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_login', value);
  }
}

import 'dart:convert';

import 'package:the_movie_app/models/account/account.dart';
import 'package:the_movie_app/utils/shared_pref.dart';

class AccountService {
  final _pref = SharedPref();

  Future<Account?> getAccountLogin() async {
    final _accountLogin = await _pref.getAccountLogin();
    return _accountLogin;
  }

  Future<List<Account>> getAccounts() async {
    final _accounts = <Account>[];
    final _jsonString = await _pref.getAccounts();

    if (_jsonString != null) {
      final jsonArray = jsonDecode(_jsonString) as List<dynamic>;
      jsonArray.asMap().forEach((int index, dynamic value) {
        try {
          final account = Account.fromJson(value as Map<String, dynamic>);
          _accounts.add(account);
        } catch (e) {
          print(e);
        }
      });
    }

    return _accounts;
  }

  Future<Map<String, dynamic>> register({
    required Account account,
  }) async {
    final _accounts = await getAccounts();

    final _isAccountDuplicated =
        _accounts.any((item) => item.email == account.email);

    if (_isAccountDuplicated == false) {
      _accounts.add(account);
      final jsonString = jsonEncode(_accounts);
      await _pref.setAccount(jsonString);

      return {
        'result': true,
        'message': null,
      };
    }

    return {
      'result': false,
      'message': 'Account already exists, please enter a new email!',
    };
  }

  Future<Map<String, dynamic>> login({
    required Account account,
  }) async {
    final _accounts = await getAccounts();

    for (final acc in _accounts) {
      if (account.email == acc.email && account.password == acc.password) {
        await _pref.setAccountLogin(acc);
        return {
          'result': true,
          'message': null,
        };
      }
    }

    return {
      'result': false,
      'message': 'Account does not exist!',
    };
  }

  Future<Map<String, dynamic>> logout() async {
    await _pref.setAccountLogin(null);
    return {
      'result': true,
      'message': null,
    };
  }
}

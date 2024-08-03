import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/models/account/account.dart';
import 'package:the_movie_app/services/account_service.dart';

final _accountService = AccountService();
final accountProvider =
    StateNotifierProvider<AccountState, Account?>((ref) => AccountState());

class AccountState extends StateNotifier<Account?> {
  AccountState() : super(null);

  Future<bool> getAccountLogin() async {
    final _accountLogin = await _accountService.getAccountLogin();

    if (_accountLogin != null) {
      state = _accountLogin;
      return true;
    } else {
      return false;
    }
  }
}

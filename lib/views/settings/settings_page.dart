import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/image_item.dart';
import 'package:the_movie_app/models/account/account.dart';
import 'package:the_movie_app/providers/account_provider.dart';

enum SettingTypeEnum { myProfile, notifications, help, logout }

class SettingsPage extends StatefulHookWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _accountLogin = useProvider(accountProvider);
    final _fullName =
        '${_accountLogin?.firstName?.capitalize()} ${_accountLogin?.lastName?.capitalize()}';
    final _accountName =
        '@${_accountLogin?.lastName}.${_accountLogin?.firstName}';

    return Scaffold(
      backgroundColor: color(AppColor.background),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          leading: arrowBackIcon(
            context: context,
            platform: defaultTargetPlatform,
          ),
          title: whiteTxt(text: 'Settings', size: 20),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: _width,
          padding: padding2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 127,
                height: 127,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(127),
                  color: color(AppColor.darkestGrey),
                ),
                child: Center(
                  child: ImageItem(
                    width: 120,
                    height: 120,
                    borderRadius: 120,
                    path: null,
                  ),
                ),
              ),
              hSpace(10),
              whiteTxt(
                text: _fullName,
                size: 18,
                weight: FontWeight.bold,
              ),
              hSpace(10),
              brightGreyTxt(
                text: _accountName,
                size: 15,
                weight: FontWeight.bold,
              ),
              hSpace(30),
              _settings(_accountLogin),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settings(Account? accountLogin) {
    final _width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        width: _width,
        padding: padding2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color(AppColor.darkestGrey1),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _settingItem(
                title: 'My Profile',
                icon: Icons.account_circle_outlined,
                onTap: () {},
              ),
              hSpace(10),
              _settingItem(
                title: 'Notifications',
                icon: Icons.notifications_none_rounded,
                onTap: () {},
              ),
              hSpace(10),
              _settingItem(
                title: 'Help',
                icon: Icons.help_outline_rounded,
                onTap: () {},
              ),
              hSpace(10),
              _settingItem(
                title: 'Logout',
                icon: Icons.logout_rounded,
                onTap: _onPressLogoutBtn,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingItem({
    required IconData icon,
    required String title,
    required void Function() onTap,
  }) {
    final _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _width,
        height: 60,
        padding: padding1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color(AppColor.darkestGrey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: color(AppColor.darkerGrey),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color(AppColor.brightGrey),
                  size: 30,
                ),
              ),
            ),
            wSpace(20),
            whiteTxt(
              text: title,
              size: 14,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressLogoutBtn() async {
    await showDialog<bool>(
      context: context,
      barrierColor: barrierColor,
      builder: (_) => logoutConfirmDlg(context),
    );
  }

  Future<void> _fetchAccountLogin() async {
    await context.read(accountProvider.notifier).getAccountLogin();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _fetchAccountLogin();
      await EasyLoading.dismiss();
    });
  }
}

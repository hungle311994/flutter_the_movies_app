import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/components/customm_text_form_field.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/models/account/account.dart';
import 'package:the_movie_app/services/account_service.dart';
import 'package:the_movie_app/utils/shared_pref.dart';
import 'package:the_movie_app/views/forgot_password/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LoginPage(),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _pref = SharedPref();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => unFocusScope(context),
      child: Scaffold(
        backgroundColor: color(AppColor.background),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox.shrink()),
              Padding(
                padding: EdgeInsets.only(bottom: _keyboardSpace),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      brightGreyTxt(
                        text: 'Hey there, ',
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      hSpace(10),
                      whiteTxt(
                        text: 'Welcome back',
                        size: 30,
                        weight: FontWeight.bold,
                      ),
                      hSpace(30),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: email,
                        icon: Icons.mail_outline,
                        onChanged: (value) {},
                      ),
                      hSpace(20),
                      CustomTextFormField(
                        controller: _passwordCont,
                        hintText: password,
                        icon: Icons.lock_outline,
                        isPasswordField: true,
                        onChanged: (value) {},
                      ),
                      hSpace(30),
                      _forgotPasswordBtn(),
                      hSpace(40),
                      _loginBtn(),
                      hSpace(20),
                      _navToRegisterBtn(),
                    ],
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordBtn() {
    return GestureDetector(
      onTap: () async {
        await Navigator.push<void>(
          context,
          PageTransition(
            child: const ForgotPasswordPage(),
            type: PageTransitionType.fade,
          ),
        );
      },
      child: brightGreyTxt(
        text: forgotPasswordBtn,
        size: 16,
      ),
    );
  }

  Widget _loginBtn() {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width - 30,
      height: 50,
      decoration: BoxDecoration(
        color: color(AppColor.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: _onPressLoginBtn,
        child: whiteTxt(
          text: loginBtn,
          size: 16,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _navToRegisterBtn() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Dont have an account yet? ',
            style: TextStyle(
              color: color(AppColor.white),
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: registerBtn,
            style: TextStyle(
              color: color(AppColor.primary),
              fontSize: 15,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await navToRegisterPage(context: context),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressLoginBtn() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      final _account = Account(
        email: _emailController.text,
        password: _passwordCont.text,
      );

      final _response = await AccountService().login(account: _account);
      if (_response.containsKey('result')) {
        final _result = _response['result'] as bool;
        final _msg = _response['message'] as String?;

        if (_result == true) {
          await _pref.setIsLogin(true);
          await showBottomToastSuccess(msg: messageLoginSuccess);
          await navToRoutePage(context: context);
        } else {
          await showBottomToastError(msg: _msg ?? '');
        }
      } else {
        await showBottomToastError(msg: errorMessageSomethingHappened);
      }
    } else {
      await showBottomToastError(msg: errorMessageSomethingHappened);
    }
  }

  Future<void> _initialize() async {
    final _isLogin = await _pref.getIsLogin();

    if (_isLogin == true) {
      await navToRoutePage(context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

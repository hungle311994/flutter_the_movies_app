import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/dialog.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';
import 'package:the_movie_app/components/customm_text_form_field.dart';
import 'package:the_movie_app/models/account/account.dart';
import 'package:the_movie_app/services/account_service.dart';
import 'package:uuid/uuid.dart';

class RegisterLoginPage extends StatefulWidget {
  const RegisterLoginPage({Key? key}) : super(key: key);

  @override
  State<RegisterLoginPage> createState() => _RegisterLoginPageState();
}

class _RegisterLoginPageState extends State<RegisterLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordCont = TextEditingController();
  final _cfmPasswordCont = TextEditingController();
  bool _isTermChecked = false;

  @override
  Widget build(BuildContext context) {
    final _keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final _height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: color(AppColor.background),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: _keyboardSpace != 0
                    ? _height - _keyboardSpace - 40
                    : _height - 50,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      hSpace(20),
                      brightGreyTxt(
                        text: 'Hey there, ',
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      hSpace(10),
                      whiteTxt(
                        text: 'Create an Account',
                        size: 25,
                        weight: FontWeight.bold,
                      ),
                      hSpace(30),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _firstNameController,
                              hintText: firstName,
                              icon: Icons.account_circle_outlined,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            hSpace(20),
                            CustomTextFormField(
                              controller: _lastNameController,
                              hintText: lastName,
                              icon: Icons.account_circle_outlined,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            hSpace(20),
                            CustomTextFormField(
                              controller: _emailController,
                              hintText: email,
                              icon: Icons.mail_outline,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            hSpace(20),
                            CustomTextFormField(
                              controller: _passwordCont,
                              hintText: password,
                              icon: Icons.lock_outline,
                              isPasswordField: true,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            hSpace(20),
                            CustomTextFormField(
                              controller: _cfmPasswordCont,
                              hintText: cfmPassword,
                              icon: Icons.lock_outline,
                              isPasswordField: true,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      hSpace(30),
                      _termFld(),
                      hSpace(40),
                      _registerBtn(),
                      hSpace(20),
                      _navTologinBtn(),
                      hSpace(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _termFld() {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width - 30,
      padding: paddingHorizontal2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isTermChecked = !_isTermChecked;
          });
        },
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: _isTermChecked,
                checkColor: color(AppColor.white),
                fillColor: MaterialStateProperty.resolveWith((states) {
                  return color(AppColor.darkGrey);
                }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: BorderSide.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _isTermChecked = !_isTermChecked;
                  });
                },
              ),
            ),
            wSpace(20),
            Flexible(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By creating an account, you agree to our ',
                      style: TextStyle(
                        color: color(AppColor.brightGrey),
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'Conditions of Use',
                      style: TextStyle(
                        color: color(AppColor.brightGrey),
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async => null,
                    ),
                    TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        color: color(AppColor.brightGrey),
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Notice',
                      style: TextStyle(
                        color: color(AppColor.brightGrey),
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async => null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerBtn() {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width - 30,
      height: 50,
      decoration: BoxDecoration(
        color: color(AppColor.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: _onPressRegisterBtn,
        child: whiteTxt(
          text: registerBtn,
          size: 16,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _navTologinBtn() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: color(AppColor.white),
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: loginBtn,
            style: TextStyle(
              color: color(AppColor.primary),
              fontSize: 15,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await navToLoginPage(context: context),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressRegisterBtn() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      if (_isTermChecked == false) {
        await showBottomToastError(msg: errorMessageAgreeTheTerm);
        return;
      }

      final _account = Account(
        id: const Uuid().v4(),
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordCont.text,
      );

      final _response = await AccountService().register(account: _account);
      if (_response.containsKey('result')) {
        final _result = _response['result'] as bool;
        final _msg = _response['message'] as String?;

        if (_result == true) {
          await showBottomToastSuccess(msg: messageRegisteredSuccess);
          await navToLoginPage(context: context);
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/components/customm_text_form_field.dart';
import 'package:the_movie_app/common/string.dart';
import 'package:the_movie_app/common/text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = ScrollController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: color(AppColor.background),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: NestedScrollView(
            controller: _controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: SliverAppBar(
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    title: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          arrowBackIcon(
                            context: context,
                            platform: defaultTargetPlatform,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Padding(
                  padding: padding2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        whiteTxt(
                          text: 'Reset password',
                          size: 30,
                          weight: FontWeight.bold,
                        ),
                        hSpace(10),
                        brightGreyTxt(text: resetPasswordGuide, size: 18),
                        hSpace(30),
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: email,
                          icon: Icons.mail_outline,
                          onChanged: (value) {},
                        ),
                        hSpace(40),
                        _sendInstructionBtn(),
                        hSpace(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sendInstructionBtn() {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width - 30,
      height: 50,
      decoration: BoxDecoration(
        color: color(AppColor.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          final form = _formKey.currentState;
          if (form != null && form.validate()) {
            print('Form is valid');
          } else {
            print('Form is invalid');
          }
        },
        child: whiteTxt(
          text: 'Send Instruction',
          size: 16,
          weight: FontWeight.bold,
        ),
      ),
    );
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

import 'package:flutter/material.dart';
import 'package:the_movie_app/common/app_sizing.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/common/common.dart';
import 'package:the_movie_app/common/string.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.isPasswordField,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final void Function(String) onChanged;
  bool? isPasswordField = false;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  TextEditingController? _controller;
  String? _hinText;
  IconData? _icon;
  bool? _isPasswordField;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Padding(
      padding: noPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: _width - 30,
            child: TextFormField(
              controller: _controller,
              cursorColor: color(AppColor.grey),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              style: TextStyle(color: color(AppColor.grey), fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              obscureText:
                  _isPasswordField == true ? !_isPasswordVisible : false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => _validateType(value: value),
              decoration: InputDecoration(
                contentPadding: noPadding,
                isCollapsed: true,
                filled: true,
                fillColor: color(AppColor.darkerGrey),
                hintStyle: TextStyle(color: color(AppColor.grey)),
                hintText: _hinText,
                border: greyBorder,
                focusedBorder: noBorder,
                errorBorder: noBorder,
                focusedErrorBorder: noBorder,
                prefixIcon: Icon(_icon, color: color(AppColor.grey)),
                suffixIcon: _isPasswordField == true
                    ? IconButton(
                        icon: Icon(
                          _isPasswordVisible == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: color(AppColor.grey),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (String str) {
                widget.onChanged(str);
              },
            ),
          ),
        ],
      ),
    );
  }

  String? _validateType({String? value}) {
    final _value = value == null || value.isEmpty;

    if (_value && _hinText == firstName) {
      return errorMessageFirstnameBlank;
    } else if (_value && _hinText == lastName) {
      return errorMessageLastnameBlank;
    } else if (_value && _hinText == email) {
      return errorMessageEmailBlank;
    } else if (_value && _hinText == password) {
      return errorMessageBlankPassword;
    } else if (_value && _hinText == cfmPassword) {
      return errorMessageBlankCfmPassword;
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _hinText = widget.hintText;
    _icon = widget.icon;
    _isPasswordField = widget.isPasswordField;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../global/style/styles.dart';

class AuthTextField extends StatefulWidget {
  final ThemeData theme;
  final AppLocalizations text;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;

  const AuthTextField.email({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.emailAddress,
    this.obscureText = false,
  });

  const AuthTextField.password({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.visiblePassword,
    this.obscureText = true,
  });

  const AuthTextField.normal({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void onChangeVisiblePasswordState() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.theme.primaryTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.theme.primaryTextTheme.bodyLarge
            ?.copyWith(color: AppColors.textGrey),
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? SizedBox(
                height: 25,
                width: 25,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    _obscureText ? AppImages.iShow : AppImages.iHide,
                  ),
                  onPressed: () => onChangeVisiblePasswordState(),
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.error, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.error, width: 1)),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    );
  }
}

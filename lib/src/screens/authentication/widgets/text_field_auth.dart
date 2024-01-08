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
  final Function? onEditingComplete;
  final int? maxLength;
  final String? Function(String?)? validator;

  const AuthTextField.email({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.emailAddress,
    this.obscureText = false,
    this.onEditingComplete,
    this.maxLength = 80,
    this.validator,
  });

  const AuthTextField.password({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.visiblePassword,
    this.obscureText = true,
    this.onEditingComplete,
    this.maxLength = 80,
    this.validator,
  });

  const AuthTextField.normal({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.onEditingComplete,
    this.maxLength = 100,
    this.validator,
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
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete != null
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onEditingComplete!();
            }
          : null,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: "",
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

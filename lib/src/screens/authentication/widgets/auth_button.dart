import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import '../../widgets/button_common.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const AuthButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return AppButton(
          onTap: state.status == AuthenticationStatus.loading
              ? () {}
              : () => onTap(),
          title: label,
          height: 56,
          child: state.status == AuthenticationStatus.loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : null,
        );
      },
    );
  }
}

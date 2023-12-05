import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/models/request/sign_up_with_email_request.dart';
import 'package:template/src/screens/authentication/widgets/sign_in_form.dart';
import 'package:template/src/screens/authentication/widgets/sign_up_form.dart';
import 'package:template/src/screens/authentication/widgets/update_user_profile_form.dart';
import 'package:template/src/screens/widgets/expandable_page_view.dart';

import 'bloc/auth_form_cubit.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late PageController _pageController;
  String _emailRegister = '';
  String _passwordRegister = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.action == AuthenticationAction.signIn &&
            state.isSuccess == true &&
            state.status == AuthenticationStatus.authenticated) {
          context.pop();
        } else if (state.action == AuthenticationAction.signUp &&
            state.isSuccess == true &&
            state.status == AuthenticationStatus.unauthenticated) {
          _pageController.animateToPage(
            3,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        } else if (state.action == AuthenticationAction.signUp &&
            state.isError == true &&
            state.status == AuthenticationStatus.unauthenticated) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: AppLocalizations.of(context)!.tryAgainLater,
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.mobileSize),
          child: SingleChildScrollView(
            child: ExpandablePageView(
              pageController: _pageController,
              pageIndex: widget.pageIndex,
              children: [
                SignInForm(
                  goSignUp: () {
                    _pageController.jumpToPage(1);
                  },
                ),
                SignUpEmailForm(
                  goSignIn: () {
                    _pageController.jumpToPage(0);
                  },
                  continueSignUp: (email) {
                    _emailRegister = email;
                    context
                        .read<AuthFormCubit>()
                        .showError();
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                SignUpPasswordForm(
                  onRegister: (password) {
                    _passwordRegister = password;
                    context
                        .read<AuthenticationBloc>()
                        .add(OnSignUpWithEmailEvent(
                          SignUpWithEmailRaw(
                            firstName: '',
                            lastName: '',
                            login: _emailRegister,
                            email: _emailRegister,
                            password: _passwordRegister,
                          ),
                        ));
                  },
                  onPrevious: () {
                    context
                        .read<AuthFormCubit>()
                        .showError();
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                UpdateUserProfileForm(
                  onComplete: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

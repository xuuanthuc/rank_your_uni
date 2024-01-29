import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/models/request/sign_up_with_email_request.dart';
import 'package:template/src/screens/authentication/widgets/forgot_password_form.dart';
import 'package:template/src/screens/authentication/widgets/sign_in_form.dart';
import 'package:template/src/screens/authentication/widgets/sign_up_form.dart';
import 'package:template/src/screens/authentication/widgets/update_user_profile_form.dart';
import 'package:template/src/screens/widgets/expandable_page_view.dart';
import '../../../global/validators/validators.dart';
import '../../global_bloc/settings/app_settings_bloc.dart';
import '../widgets/primary_dialog.dart';
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
            state.status == AuthenticationStatus.authenticated) {
          context.read<AppSettingsBloc>().add(GetUserProfileEvent());
          _pageController.animateToPage(
            PageIndex.updateProfile,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        } else if (state.action == AuthenticationAction.signUp &&
            state.isError == true &&
            state.status == AuthenticationStatus.unauthenticated) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: state.errorMessage,
          );
        } else if (state.action == AuthenticationAction.forgotPassword &&
            state.isError == true) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: state.errorMessage,
          );
        } else if (state.action == AuthenticationAction.forgotPassword &&
            state.isSuccess == true){
          appToast(
            context,
            message: AppLocalizations.of(context)!.submitSuccess,
            subMessage: AppLocalizations.of(context)!.checkYourEmail,
            type: ToastType.success
          );
        }
      },
      child: PrimaryDialog(
        child: ExpandablePageView(
          pageController: _pageController,
          pageIndex: widget.pageIndex,
          children: [
            SignInForm(
              goSignUp: () {
                context.read<AuthFormCubit>().showError();
                _pageController.jumpToPage(PageIndex.signUpEmail);
              },
              goToForgotPassword: () {
                context.read<AuthFormCubit>().showError();
                _pageController.jumpToPage(PageIndex.forgotPassword);
              },
            ),
            SignUpEmailForm(
              goSignIn: () {
                context.read<AuthFormCubit>().showError();
                _pageController.jumpToPage(PageIndex.signIn);
              },
              continueSignUp: (email) {
                final text = AppLocalizations.of(context)!;
                if (TextFieldValidator.emailValidator(email) !=
                    null) {
                  context
                      .read<AuthFormCubit>()
                      .showError(error: text.invalidEmail);
                } else {
                  _emailRegister = email;
                  context.read<AuthFormCubit>().showError();
                  _pageController.animateToPage(
                    PageIndex.signUpPassword,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
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
                context.read<AuthFormCubit>().showError();
                _pageController.animateToPage(
                  PageIndex.signUpEmail,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
            const UpdateUserProfileForm(),
            const ForgotPasswordForm(),
          ],
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

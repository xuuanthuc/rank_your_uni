import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/dashboard/bloc/authenticate/dashboard_authentication_cubit.dart';
import 'package:video_player/video_player.dart';
import '../../models/request/sign_in_with_email_request.dart';
import '../../screens/authentication/widgets/auth_field_label.dart';
import '../../screens/authentication/widgets/google_auth_button.dart';
import '../../screens/authentication/widgets/text_field_auth.dart';
import '../../screens/widgets/loading_primary_button.dart';

class DashboardLogin extends StatefulWidget {
  const DashboardLogin({super.key});

  @override
  State<DashboardLogin> createState() => _DashboardLoginState();
}

class _DashboardLoginState extends State<DashboardLogin> {
  final VideoPlayerController _controller =
      VideoPlayerController.asset(AppImages.bgDashboardLoginMp4)
        ..initialize()
        ..setVolume(0)
        ..setLooping(true);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSignGoogleSignIn(BuildContext context) {}

  void _onSignIn(BuildContext context, SignInWithEmailRaw raw) {
    context.read<DashboardAuthenticationCubit>().signInDashboard(raw);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller.play();
      });
    });
    return BlocListener<DashboardAuthenticationCubit,
        DashboardAuthenticationState>(
      listener: (context, state) {
        if (state.status == DashboardAuthenticationStatus.success) {
          context.goNamed(RouteKey.dashboard);
        } else if (state.status == DashboardAuthenticationStatus.error) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: state.errorMessage,
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            BlocBuilder<DashboardAuthenticationCubit,
                DashboardAuthenticationState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Center(
                    child: MouseRegion(
                      onEnter: (details) => context
                          .read<DashboardAuthenticationCubit>()
                          .onHover(false),
                      onExit: (details) => context
                          .read<DashboardAuthenticationCubit>()
                          .onHover(true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                              (state.isHovering ?? true) ? 0.3 : 1),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 50,
                                spreadRadius: 20,
                                offset: Offset(20, 20))
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 35),
                        margin: const EdgeInsets.all(20),
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              text.signIn,
                              style: theme.primaryTextTheme.displayLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 45),
                            AuthWithGoogleButton(
                              theme: theme,
                              text: text.signInWithGoogle,
                              onAuthWithGoogle: () =>
                                  _onSignGoogleSignIn(context),
                            ),
                            const SizedBox(height: 26),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.grey,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  text.orSignInWithEmail,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                            AuthFormLabel(
                              theme,
                              text: text.email,
                            ),
                            AuthTextField.email(
                              theme: theme,
                              text: text,
                              hintText: text.enterEmail,
                              controller: _emailController,
                              validator: TextFieldValidator.notEmptyValidator,
                            ),
                            const SizedBox(height: 26),
                            AuthFormLabel(
                              theme,
                              text: text.password,
                            ),
                            AuthTextField.password(
                              theme: theme,
                              text: text,
                              hintText: text.enterPassword,
                              controller: _passwordController,
                              validator: TextFieldValidator.passValidator,
                              onEditingComplete: () {
                                _onSignIn(
                                  context,
                                  SignInWithEmailRaw(
                                    username: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 14),
                            LoadingPrimaryButton<DashboardAuthenticationCubit,
                                DashboardAuthenticationState>(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _onSignIn(
                                    context,
                                    SignInWithEmailRaw(
                                      username: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },
                              label: text.signIn,
                              updateLoading: (state) {
                                return state.status ==
                                    DashboardAuthenticationStatus.loading;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

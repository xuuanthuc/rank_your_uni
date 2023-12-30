import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/utilities/static_variable.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import '../../../global/routes/route_keys.dart';
import '../../global_bloc/authentication/authentication_bloc.dart';
import '../appbar/appbar_common.dart';
import 'footer_common.dart';

class AppScaffold extends StatefulWidget {
  final List<Widget> children;
  final String? keyword;
  final bool? needToHome;

  const AppScaffold({
    super.key,
    required this.children,
    this.keyword,
    this.needToHome,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    super.initState();
    if (StaticVariable.tokenIsNotChecked) {
      context.read<AuthenticationBloc>().add(OnCheckToken());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (_, cur) => cur.action == AuthenticationAction.refreshToken,
      listener: (context, state) {
        if (state.isSuccess == true) {
          context.read<AppSettingsBloc>().add(GetUserProfileEvent());
        }
        if (state.status == AuthenticationStatus.unauthenticated &&
            state.action == AuthenticationAction.refreshToken &&
            state.isLoading == false &&
            state.isSuccess == false &&
            widget.needToHome == true) {
          context.goNamed(RouteKey.home);
        }
      },
      child: SelectionArea(
        child: Scaffold(
          appBar: AppbarCommon(keyword: widget.keyword),
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  widget.children,
                ),
              ),
              const SliverFillRemaining(
                hasScrollBody: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FooterCommon(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

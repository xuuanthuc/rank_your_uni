import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/utilities/static_variable.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/screens/guideline/contact_screen.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/routes/route_keys.dart';
import '../../../global/utilities/public.dart';
import '../../global_bloc/authentication/authentication_bloc.dart';
import '../appbar/appbar_common.dart';
import 'primary_footer.dart';

class AppScaffold extends StatefulWidget {
  final List<Widget> children;
  final String? keyword;
  final bool? requireAuthenticated;
  final double maxContentWidth;
  final double maxWidth;
  final CrossAxisAlignment crossAxisAlignment;
  final Alignment alignment;
  final EdgeInsets? margin;

  const AppScaffold({
    super.key,
    required this.children,
    this.keyword,
    this.requireAuthenticated,
    this.maxContentWidth = Public.laptopSize,
    this.maxWidth = Public.laptopSize,
    this.alignment = Alignment.center,
    this.margin,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final ScrollController _controller = ScrollController();

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
          final pr = state.profile;
          if (pr != null) {
            context.read<AppSettingsBloc>().add(InitUserProfileEvent(pr));
          }
        } else if (state.status == AuthenticationStatus.unauthenticated &&
            state.isLoading == false &&
            state.isSuccess == false &&
            widget.requireAuthenticated == true) {
          context.goNamed(RouteKey.home);
        }
      },
      child: SelectionArea(
        child: Scaffold(
          appBar: AppbarCommon(keyword: widget.keyword),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierColor: Colors.black12,
                  builder: (BuildContext context) {
                    return const ContactUsDialog();
                  },
                );
              },
              child: const Icon(Icons.question_mark),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              controller: _controller,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        margin: widget.margin ??
                            EdgeInsets.all(
                              ResponsiveBuilder.setHorizontalPadding(context),
                            ),
                        constraints: BoxConstraints(
                          maxWidth: widget.maxWidth,
                        ),
                        child: Align(
                          alignment: widget.alignment,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: widget.maxContentWidth,
                            ),
                            child: Column(
                              crossAxisAlignment: widget.crossAxisAlignment,
                              children: widget.children,
                            ),
                          ),
                        ),
                      ),
                    ),
                    PrimaryFooter(
                      controller: _controller,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

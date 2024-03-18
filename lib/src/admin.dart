import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_themes.dart';
import 'package:template/global/utilities/static_variable.dart';
import 'package:template/src/dashboard/bloc/authenticate/dashboard_authentication_cubit.dart';
import 'package:template/src/di/dependencies.dart';
import '../global/routes/route_keys.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dashboard/bloc/dashboard_cubit.dart';
import 'dashboard/dashboard_root_screen.dart';
import 'dashboard/features/dashboard_login.dart';

class MyAdmin extends StatelessWidget {
  const MyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (BuildContext context, GoRouterState state) {
            if (StaticVariable.dashboardToken != null) {
              return '/dashboard';
            } else {
              return null;
            }
          },
          name: RouteKey.authDashboard,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const DashboardLogin(),
          ),
        ),
        GoRoute(
          path: '/dashboard',
          name: RouteKey.dashboard,
          redirect: (BuildContext context, GoRouterState state) {
            if (StaticVariable.dashboardToken == null) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: BlocProvider(
              create: (context) => getIt.get<DashboardCubit>(),
              child: const DashboardScreen(),
            ),
          ),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt.get<DashboardAuthenticationCubit>()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: "Rank Your UNi",
          theme: AppThemes.lightTheme,
          locale: const Locale('vi', ''),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
  }
}

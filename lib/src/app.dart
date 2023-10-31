import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_themes.dart';
import 'package:template/src/screens/home/home_screen.dart';
import 'package:template/src/screens/search/search_screen.dart';
import '../global/routes/route_keys.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'global_bloc/connectivity/connectivity_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final router = GoRouter(
      routes: [
        GoRoute(
          path: RouteKey.home,
          builder: (context, state) => const HomeScreen(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: RouteKey.search,
          name: RouteKey.search,
          builder: (context, state) => const SearchScreen(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const SearchScreen(),
          ),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityBloc()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: "Rate Your Uni",
          theme: AppThemes.lightTheme,
          locale: const Locale('vi', ''),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          // routerDelegate: router.routerDelegate,
          // navigatorObservers: [MyRouteObserver()],
          // onGenerateRoute: AppRoutes.onGenerateRoutes,
          // onGenerateInitialRoutes: (_) => AppRoutes.onGenerateInitialRoute(),
          // navigatorKey: NavigationService.navigationKey,
        ),
      ),
    );
  }
}



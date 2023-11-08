import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_themes.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/screens/compare/compare_university.dart';
import 'package:template/src/screens/detail/university_detail.dart';
import 'package:template/src/screens/home/home_screen.dart';
import 'package:template/src/screens/review/review_screen.dart';
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
          path: '/a',
          name: RouteKey.home,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          // path: '/university/:id',
          path: '/',
          name: RouteKey.university,
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: UniversityDetail(
                // id: int.parse(data["id"] as String),
                id: 100,
              ),
            );
          },
        ),
        GoRoute(
          path: '/search/school',
          name: RouteKey.search,
          pageBuilder: (context, state) {
            final data = state.uri.queryParameters;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: SearchScreen(
                keyword: data['q'],
              ),
            );
          },
        ),
        GoRoute(
          path: '/review/university/:id',
          name: RouteKey.review,
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ReviewForm(
                universityId: data['id'] as String,
              ),
            );
          },
        ),
        GoRoute(
          path: '/compare/university/:id',
          name: RouteKey.compare,
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            final extra = state.extra;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: CompareScreen(
                universityId: data['id'] as String,
              ),
            );
          },
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityBloc()),
        BlocProvider(create: (context) => getIt.get<AuthenticationBloc>()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: "Rank Your Uni",
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

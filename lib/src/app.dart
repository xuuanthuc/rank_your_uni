import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_themes.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/add/add_professor.dart';
import 'package:template/src/screens/add/add_university.dart';
import 'package:template/src/screens/appbar/widgets/user_button.dart';
import 'package:template/src/screens/detail/professor_detail.dart';
import 'package:template/src/screens/reset/reset_password_screen.dart';
import 'package:template/src/screens/compare/compare_university.dart';
import 'package:template/src/screens/detail/university_detail.dart';
import 'package:template/src/screens/guideline/guideline_screen.dart';
import 'package:template/src/screens/guideline/help_screen.dart';
import 'package:template/src/screens/home/home_screen.dart';
import 'package:template/src/screens/profile/profile_screen.dart';
import 'package:template/src/screens/review/delete_review_success.dart';
import 'package:template/src/screens/review/review_screen.dart';
import 'package:template/src/screens/review/review_success.dart';
import 'package:template/src/screens/search/search_professores_screen.dart';
import 'package:template/src/screens/search/search_screen.dart';
import 'package:template/src/screens/term_and_policy/privacy_policy_screen.dart';
import 'package:template/src/screens/term_and_policy/terms_of_services.dart';
import '../global/routes/route_keys.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/request/edit_review_param.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: RouteKey.home,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/university/:id',
          name: RouteKey.university,
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            final University? university = state.extra as University?;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: UniversityDetail(
                id: int.parse(data["id"] as String),
                university: university,
              ),
            );
          },
        ),
        GoRoute(
          path: '/lecturer/:id',
          name: RouteKey.professor,
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            final Professor? professor = state.extra as Professor?;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ProfessorDetail(
                id: int.parse(data["id"] as String),
                professor: professor,
              ),
            );
          },
        ),
        GoRoute(
          path: '/search/school',
          name: RouteKey.searchUniversity,
          redirect: (BuildContext context, GoRouterState state) {
            final data = state.uri.queryParameters;
            if ((data['q'] ?? '').isEmpty) {
              return '/';
            } else {
              return null;
            }
          },
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
          path: '/search/lecturers',
          name: RouteKey.searchProfessor,
          redirect: (BuildContext context, GoRouterState state) {
            final data = state.uri.queryParameters;
            if ((data['q'] ?? '').isEmpty) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) {
            final data = state.uri.queryParameters;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: SearchProfessorScreen(
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
            final University? university = state.extra as University?;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ReviewForm(
                universityId: data['id'] as String,
                university: university,
              ),
            );
          },
        ),
        GoRoute(
          path: '/edit-review/university/:uniId/:reviewId',
          name: RouteKey.editReview,
          redirect: (BuildContext context, GoRouterState state) {
            EditReviewParam? param = state.extra as EditReviewParam?;
            if (param == null) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            EditReviewParam? param = state.extra as EditReviewParam?;
            param ??= const EditReviewParam();
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ReviewForm(
                universityId: data['uniId'] as String,
                university: param.university,
                review: param.review,
              ),
            );
          },
        ),
        GoRoute(
          path: '/compare/university/:id',
          name: RouteKey.compare,
          pageBuilder: (context, state) {
            final data = state.pathParameters;
            final University? university = state.extra as University?;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: CompareScreen(
                universityId: data['id'] as String,
                universityInitial: university,
              ),
            );
          },
        ),
        GoRoute(
          path: '/compare/university/:id/:withUniId',
          name: RouteKey.compareWith,
          pageBuilder: (context, state) {
            final University? university = state.extra as University?;
            final data = state.pathParameters;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: CompareScreen(
                universityId: data['id'] as String,
                compareWithUniversityId: data['withUniId'] as String,
                universityInitial: university,
              ),
            );
          },
        ),
        GoRoute(
          path: '/account/reset/finish',
          name: RouteKey.resetPassword,
          redirect: (BuildContext context, GoRouterState state) {
            final data = state.uri.queryParameters;
            if (data['key'] == null) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) {
            final data = state.uri.queryParameters;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ResetPasswordScreen(
                resetKey: data['key'] as String,
              ),
            );
          },
        ),
        GoRoute(
          path: '/compare/university',
          name: RouteKey.reset,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const CompareScreen(),
            );
          },
        ),
        GoRoute(
          path: '/review-university/success',
          name: RouteKey.reviewSuccess,
          redirect: (BuildContext context, GoRouterState state) {
            University? param = state.extra as University?;
            if (param == null) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) {
            final university = state.extra as University;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ReviewSuccessScreen(
                university: university,
              ),
            );
          },
        ),
        GoRoute(
          path: '/review-university/delete',
          name: RouteKey.deteleSuccess,
          redirect: (BuildContext context, GoRouterState state) {
            University? param = state.extra as University?;
            if (param == null) {
              return '/';
            } else {
              return null;
            }
          },
          pageBuilder: (context, state) {
            final university = state.extra as University;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: ReviewDeletedSuccessScreen(
                university: university,
              ),
            );
          },
        ),
        GoRoute(
          path: '/account/profile',
          name: RouteKey.profile,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const ProfileScreen(menu: QuickMenu.profile),
            );
          },
        ),
        GoRoute(
          path: '/account/setting',
          name: RouteKey.account,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const ProfileScreen(menu: QuickMenu.settingAccount),
            );
          },
        ),
        GoRoute(
          path: '/account/ratings',
          name: RouteKey.yourRating,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const ProfileScreen(menu: QuickMenu.yourRating),
            );
          },
        ),
        GoRoute(
          path: '/guidelines',
          name: RouteKey.guidelines,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const GuidelinesScreen(),
            );
          },
        ),
        GoRoute(
          path: '/helps',
          name: RouteKey.helps,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const HelpScreen(),
            );
          },
        ),
        GoRoute(
          path: '/add/university',
          name: RouteKey.addUniversity,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AddUniversity(),
            );
          },
        ),
        GoRoute(
          path: '/add/lecturer',
          name: RouteKey.addProfessor,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AddProfessor(),
            );
          },
        ),
        GoRoute(
          path: '/terms',
          name: RouteKey.terms,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const TermsOfServiceScreen(),
            );
          },
        ),
        GoRoute(
          path: '/policy',
          name: RouteKey.policy,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const PrivacyPolicyScreen(),
            );
          },
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<AuthenticationBloc>()),
        BlocProvider(create: (context) => getIt.get<AppSettingsBloc>()),
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

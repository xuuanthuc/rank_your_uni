import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/home/widgets/home_description.dart';
import 'package:template/src/screens/home/widgets/landing_view.dart';
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart';
import '../widgets/base_scaffold.dart';
import 'bloc/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AutocompletionCubit>(),
        ),
      ],
      child: AppScaffold(
        maxWidth: MediaQuery.sizeOf(context).width,
        maxContentWidth: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.zero,
        children: [
          LandingView(
            onSearch: (keyword) {
              context.goNamed(
                RouteKey.search,
                queryParameters: {"q": keyword},
              );
            },
          ),
          const HomeDescription(),
        ],
      ),
    );
  }
}

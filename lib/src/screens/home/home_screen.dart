import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/home/widgets/home_description.dart';
import 'package:template/src/screens/home/widgets/landing_view.dart';
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart';
import '../../global_bloc/connectivity/connectivity_bloc.dart';
import '../widgets/base_scaffold.dart';
import 'bloc/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityChangedState) {
          if (state.result == ConnectivityResult.none) {
            appToast(context, message: "No connection");
          }
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<HomeCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<AutocompletionCubit>(),
          ),
        ],
        child: SelectionArea(
          child: AppScaffold(
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
        ),
      ),
    );
  }
}

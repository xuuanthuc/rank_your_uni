import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/app_images.dart';
import 'package:template/global/utilities/public.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/home/widgets/home_description.dart';
import 'package:template/src/screens/home/widgets/landing_view.dart';
import '../../global_bloc/connectivity/connectivity_bloc.dart';
import '../widgets/appbar_common.dart';
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
      child: BlocProvider(
        create: (context) => getIt.get<HomeCubit>(),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // context.read<HomeCubit>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: const AppbarCommon(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const LandingView(),
              HomeDescription()
            ],
          ),
        ),
      ),
    );
  }
}

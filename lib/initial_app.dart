import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import './../../src/di/dependencies.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('SimpleBlocObserver onEvent = $event');
    super.onEvent(bloc, event);
  }
}

Future<void> initialApp(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = AppBlocObserver();
  setUrlStrategy(PathUrlStrategy());
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyClyX0rLU0gCJ6nLcYuLdw4tj1PzhGilbg",
      appId: "1:680959591423:web:1d94a128b2230134b55dca",
      messagingSenderId: "680959591423",
      projectId: "rankyouruni",
    ),
  );
  runApp(await builder());
}
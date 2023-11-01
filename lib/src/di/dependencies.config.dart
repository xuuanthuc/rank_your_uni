// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template/src/network/api_provider.dart' as _i3;
import 'package:template/src/repositories/post_repository.dart' as _i6;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i5;
import 'package:template/src/screens/widgets/bloc/appbar_cubit.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt $initDependencies({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiProvider>(_i3.ApiProvider());
    gh.factory<_i4.AppbarCubit>(() => _i4.AppbarCubit());
    gh.factory<_i4.AppbarState>(() => _i4.AppbarState(
          onShowSmallTextField: gh<bool>(),
          status: gh<_i4.AppbarStatus>(),
        ));
    gh.factory<_i5.HomeState>(
        () => _i5.HomeState(status: gh<_i5.HomeStatus>()));
    gh.factory<_i6.PostRepository>(() => _i6.PostRepository());
    gh.factory<_i5.HomeCubit>(() => _i5.HomeCubit(gh<_i6.PostRepository>()));
    return this;
  }
}

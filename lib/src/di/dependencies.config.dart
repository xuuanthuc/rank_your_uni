// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart'
    as _i5;
import 'package:template/src/network/api_provider.dart' as _i3;
import 'package:template/src/repositories/post_repository.dart' as _i9;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i4;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i6;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i7;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i8;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i10;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i11;

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
    gh.factory<_i5.AuthenticationBloc>(() => _i5.AuthenticationBloc());
    gh.factory<_i5.AuthenticationState>(() => _i5.AuthenticationState(
          isLoading: gh<bool>(),
          isSuccess: gh<bool>(),
          status: gh<_i5.AuthenticationStatus>(),
          action: gh<_i5.AuthenticationAction>(),
        ));
    gh.factory<_i6.CompareCubit>(() => _i6.CompareCubit());
    gh.factory<_i7.HelpCubit>(() => _i7.HelpCubit());
    gh.factory<_i8.HomeState>(
        () => _i8.HomeState(status: gh<_i8.HomeStatus>()));
    gh.factory<_i9.PostRepository>(() => _i9.PostRepository());
    gh.factory<_i10.ProfileCubit>(() => _i10.ProfileCubit());
    gh.factory<_i11.SearchCubit>(() => _i11.SearchCubit());
    gh.factory<_i8.HomeCubit>(() => _i8.HomeCubit(gh<_i9.PostRepository>()));
    return this;
  }
}

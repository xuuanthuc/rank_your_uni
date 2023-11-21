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
import 'package:template/src/repositories/detail_repository.dart' as _i6;
import 'package:template/src/repositories/search_repository.dart' as _i11;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i4;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i13;
import 'package:template/src/screens/detail/bloc/detail_cubit.dart' as _i14;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i7;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i8;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i9;
import 'package:template/src/screens/review/bloc/review_cubit.dart' as _i10;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i15;
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart'
    as _i12;

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
    gh.factory<_i6.DetailRepository>(() => _i6.DetailRepository());
    gh.factory<_i7.HelpCubit>(() => _i7.HelpCubit());
    gh.factory<_i8.HomeCubit>(() => _i8.HomeCubit());
    gh.factory<_i8.HomeState>(
        () => _i8.HomeState(status: gh<_i8.HomeStatus>()));
    gh.factory<_i9.ProfileCubit>(() => _i9.ProfileCubit());
    gh.factory<_i10.ReviewCubit>(
        () => _i10.ReviewCubit(gh<_i6.DetailRepository>()));
    gh.factory<_i11.SearchRepository>(() => _i11.SearchRepository());
    gh.factory<_i12.AutocompletionCubit>(
        () => _i12.AutocompletionCubit(gh<_i11.SearchRepository>()));
    gh.factory<_i13.CompareCubit>(
        () => _i13.CompareCubit(gh<_i6.DetailRepository>()));
    gh.factory<_i14.DetailCubit>(
        () => _i14.DetailCubit(gh<_i6.DetailRepository>()));
    gh.factory<_i15.SearchCubit>(
        () => _i15.SearchCubit(gh<_i11.SearchRepository>()));
    return this;
  }
}

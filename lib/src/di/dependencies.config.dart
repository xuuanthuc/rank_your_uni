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
    as _i6;
import 'package:template/src/network/api_provider.dart' as _i4;
import 'package:template/src/repositories/detail_repository.dart' as _i7;
import 'package:template/src/repositories/search_repository.dart' as _i13;
import 'package:template/src/screens/add/bloc/add_university_cubit.dart' as _i3;
import 'package:template/src/screens/add/bloc/select_province_cubit.dart'
    as _i14;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i5;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i16;
import 'package:template/src/screens/detail/bloc/detail_cubit.dart' as _i17;
import 'package:template/src/screens/detail/bloc/report_cubit.dart' as _i11;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i8;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i9;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i10;
import 'package:template/src/screens/review/bloc/review_cubit.dart' as _i12;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i18;
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart'
    as _i15;

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
    gh.factory<_i3.AddUniversityCubit>(() => _i3.AddUniversityCubit());
    gh.singleton<_i4.ApiProvider>(_i4.ApiProvider());
    gh.factory<_i5.AppbarCubit>(() => _i5.AppbarCubit());
    gh.factory<_i5.AppbarState>(() => _i5.AppbarState(
          onShowSmallTextField: gh<bool>(),
          status: gh<_i5.AppbarStatus>(),
        ));
    gh.factory<_i6.AuthenticationBloc>(() => _i6.AuthenticationBloc());
    gh.factory<_i6.AuthenticationState>(() => _i6.AuthenticationState(
          isLoading: gh<bool>(),
          isSuccess: gh<bool>(),
          status: gh<_i6.AuthenticationStatus>(),
          action: gh<_i6.AuthenticationAction>(),
        ));
    gh.factory<_i7.DetailRepository>(() => _i7.DetailRepository());
    gh.factory<_i8.HelpCubit>(() => _i8.HelpCubit());
    gh.factory<_i9.HomeCubit>(() => _i9.HomeCubit());
    gh.factory<_i9.HomeState>(
        () => _i9.HomeState(status: gh<_i9.HomeStatus>()));
    gh.factory<_i10.ProfileCubit>(() => _i10.ProfileCubit());
    gh.factory<_i11.ReportCubit>(
        () => _i11.ReportCubit(gh<_i7.DetailRepository>()));
    gh.factory<_i12.ReviewCubit>(
        () => _i12.ReviewCubit(gh<_i7.DetailRepository>()));
    gh.factory<_i13.SearchRepository>(() => _i13.SearchRepository());
    gh.factory<_i14.SelectProvinceCubit>(() => _i14.SelectProvinceCubit());
    gh.factory<_i15.AutocompletionCubit>(
        () => _i15.AutocompletionCubit(gh<_i13.SearchRepository>()));
    gh.factory<_i16.CompareCubit>(
        () => _i16.CompareCubit(gh<_i7.DetailRepository>()));
    gh.factory<_i17.DetailCubit>(
        () => _i17.DetailCubit(gh<_i7.DetailRepository>()));
    gh.factory<_i18.SearchCubit>(
        () => _i18.SearchCubit(gh<_i13.SearchRepository>()));
    return this;
  }
}

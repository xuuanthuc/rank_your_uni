// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i19;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template/global/storage/storage_provider.dart' as _i18;
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart'
    as _i8;
import 'package:template/src/network/api_provider.dart' as _i4;
import 'package:template/src/repositories/auth_repository.dart' as _i7;
import 'package:template/src/repositories/detail_repository.dart' as _i9;
import 'package:template/src/repositories/search_repository.dart' as _i16;
import 'package:template/src/screens/add/bloc/add_university_cubit.dart' as _i3;
import 'package:template/src/screens/add/bloc/select_province_cubit.dart'
    as _i17;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i5;
import 'package:template/src/screens/authentication/bloc/auth_form_cubit.dart'
    as _i6;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i21;
import 'package:template/src/screens/detail/bloc/detail_cubit.dart' as _i22;
import 'package:template/src/screens/detail/bloc/report_cubit.dart' as _i13;
import 'package:template/src/screens/detail/bloc/review_item_cubit.dart'
    as _i15;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i10;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i11;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i12;
import 'package:template/src/screens/review/bloc/review_cubit.dart' as _i14;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i23;
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart'
    as _i20;

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
    gh.factory<_i6.AuthFormCubit>(() => _i6.AuthFormCubit());
    gh.factory<_i7.AuthRepository>(() => _i7.AuthRepository());
    gh.factory<_i8.AuthenticationBloc>(
        () => _i8.AuthenticationBloc(gh<_i7.AuthRepository>()));
    gh.factory<_i8.AuthenticationState>(() => _i8.AuthenticationState(
          isLoading: gh<bool>(),
          isSuccess: gh<bool>(),
          status: gh<_i8.AuthenticationStatus>(),
          action: gh<_i8.AuthenticationAction>(),
          isError: gh<bool>(),
        ));
    gh.factory<_i9.DetailRepository>(() => _i9.DetailRepository());
    gh.factory<_i10.HelpCubit>(() => _i10.HelpCubit());
    gh.factory<_i11.HomeCubit>(() => _i11.HomeCubit());
    gh.factory<_i11.HomeState>(
        () => _i11.HomeState(status: gh<_i11.HomeStatus>()));
    gh.factory<_i12.ProfileCubit>(() => _i12.ProfileCubit());
    gh.factory<_i13.ReportCubit>(
        () => _i13.ReportCubit(gh<_i9.DetailRepository>()));
    gh.factory<_i14.ReviewCubit>(
        () => _i14.ReviewCubit(gh<_i9.DetailRepository>()));
    gh.factory<_i15.ReviewItemCubit>(
        () => _i15.ReviewItemCubit(gh<_i9.DetailRepository>()));
    gh.factory<_i16.SearchRepository>(() => _i16.SearchRepository());
    gh.factory<_i17.SelectProvinceCubit>(() => _i17.SelectProvinceCubit());
    gh.lazySingleton<_i18.StorageProvider>(
        () => _i18.StorageProvider(gh<_i19.FlutterSecureStorage>()));
    gh.factory<_i20.AutocompletionCubit>(
        () => _i20.AutocompletionCubit(gh<_i16.SearchRepository>()));
    gh.factory<_i21.CompareCubit>(
        () => _i21.CompareCubit(gh<_i9.DetailRepository>()));
    gh.factory<_i22.DetailCubit>(
        () => _i22.DetailCubit(gh<_i9.DetailRepository>()));
    gh.factory<_i23.SearchCubit>(
        () => _i23.SearchCubit(gh<_i16.SearchRepository>()));
    return this;
  }
}

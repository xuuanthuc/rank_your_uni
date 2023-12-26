// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i21;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template/global/storage/storage_provider.dart' as _i20;
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart'
    as _i10;
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart'
    as _i5;
import 'package:template/src/models/response/profile.dart' as _i6;
import 'package:template/src/network/api_provider.dart' as _i4;
import 'package:template/src/repositories/auth_repository.dart' as _i9;
import 'package:template/src/repositories/detail_repository.dart' as _i11;
import 'package:template/src/repositories/search_repository.dart' as _i18;
import 'package:template/src/repositories/user_repository.dart' as _i22;
import 'package:template/src/screens/add/bloc/add_university_cubit.dart' as _i3;
import 'package:template/src/screens/add/bloc/select_province_cubit.dart'
    as _i19;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i7;
import 'package:template/src/screens/authentication/bloc/auth_form_cubit.dart'
    as _i8;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i24;
import 'package:template/src/screens/detail/bloc/detail_cubit.dart' as _i25;
import 'package:template/src/screens/detail/bloc/report_cubit.dart' as _i15;
import 'package:template/src/screens/detail/bloc/review_item_cubit.dart'
    as _i17;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i12;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i13;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i14;
import 'package:template/src/screens/review/bloc/review_cubit.dart' as _i16;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i26;
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart'
    as _i23;

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
    gh.factory<_i5.AppSettingsState>(() => _i5.AppSettingsState(
          status: gh<_i5.AppSettingStatus>(),
          action: gh<_i5.AppSettingAction>(),
          errorMessage: gh<String>(),
          profileAuthenticated: gh<_i6.Profile>(),
        ));
    gh.factory<_i7.AppbarCubit>(() => _i7.AppbarCubit());
    gh.factory<_i7.AppbarState>(() => _i7.AppbarState(
          onShowSmallTextField: gh<bool>(),
          status: gh<_i7.AppbarStatus>(),
        ));
    gh.factory<_i8.AuthFormCubit>(() => _i8.AuthFormCubit());
    gh.factory<_i9.AuthRepository>(() => _i9.AuthRepository());
    gh.factory<_i10.AuthenticationBloc>(
        () => _i10.AuthenticationBloc(gh<_i9.AuthRepository>()));
    gh.factory<_i10.AuthenticationState>(() => _i10.AuthenticationState(
          isLoading: gh<bool>(),
          isSuccess: gh<bool>(),
          status: gh<_i10.AuthenticationStatus>(),
          action: gh<_i10.AuthenticationAction>(),
          isError: gh<bool>(),
          errorMessage: gh<String>(),
        ));
    gh.factory<_i11.DetailRepository>(() => _i11.DetailRepository());
    gh.factory<_i12.HelpCubit>(() => _i12.HelpCubit());
    gh.factory<_i13.HomeCubit>(() => _i13.HomeCubit());
    gh.factory<_i13.HomeState>(
        () => _i13.HomeState(status: gh<_i13.HomeStatus>()));
    gh.factory<_i14.ProfileCubit>(
        () => _i14.ProfileCubit(gh<_i9.AuthRepository>()));
    gh.factory<_i15.ReportCubit>(
        () => _i15.ReportCubit(gh<_i11.DetailRepository>()));
    gh.factory<_i16.ReviewCubit>(
        () => _i16.ReviewCubit(gh<_i11.DetailRepository>()));
    gh.factory<_i17.ReviewItemCubit>(
        () => _i17.ReviewItemCubit(gh<_i11.DetailRepository>()));
    gh.factory<_i18.SearchRepository>(() => _i18.SearchRepository());
    gh.factory<_i19.SelectProvinceCubit>(() => _i19.SelectProvinceCubit());
    gh.lazySingleton<_i20.StorageProvider>(
        () => _i20.StorageProvider(gh<_i21.FlutterSecureStorage>()));
    gh.factory<_i22.UserRepository>(() => _i22.UserRepository());
    gh.factory<_i5.AppSettingsBloc>(
        () => _i5.AppSettingsBloc(gh<_i22.UserRepository>()));
    gh.factory<_i23.AutocompletionCubit>(
        () => _i23.AutocompletionCubit(gh<_i18.SearchRepository>()));
    gh.factory<_i24.CompareCubit>(
        () => _i24.CompareCubit(gh<_i11.DetailRepository>()));
    gh.factory<_i25.DetailCubit>(
        () => _i25.DetailCubit(gh<_i11.DetailRepository>()));
    gh.factory<_i26.SearchCubit>(
        () => _i26.SearchCubit(gh<_i18.SearchRepository>()));
    return this;
  }
}

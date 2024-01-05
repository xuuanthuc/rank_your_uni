// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i20;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template/global/storage/storage_provider.dart' as _i19;
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart'
    as _i9;
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart'
    as _i4;
import 'package:template/src/models/response/profile.dart' as _i5;
import 'package:template/src/network/api_provider.dart' as _i3;
import 'package:template/src/repositories/auth_repository.dart' as _i8;
import 'package:template/src/repositories/detail_repository.dart' as _i10;
import 'package:template/src/repositories/search_repository.dart' as _i17;
import 'package:template/src/repositories/user_repository.dart' as _i21;
import 'package:template/src/screens/add/bloc/add_university_cubit.dart'
    as _i22;
import 'package:template/src/screens/add/bloc/select_province_cubit.dart'
    as _i18;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i6;
import 'package:template/src/screens/authentication/bloc/auth_form_cubit.dart'
    as _i7;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i24;
import 'package:template/src/screens/detail/bloc/detail_cubit.dart' as _i25;
import 'package:template/src/screens/detail/bloc/report_cubit.dart' as _i13;
import 'package:template/src/screens/detail/bloc/review_item_cubit.dart'
    as _i16;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i11;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i12;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i26;
import 'package:template/src/screens/reset/bloc/reset_password_cubit.dart'
    as _i14;
import 'package:template/src/screens/review/bloc/review_cubit.dart' as _i15;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i27;
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
    gh.singleton<_i3.ApiProvider>(_i3.ApiProvider());
    gh.factory<_i4.AppSettingsState>(() => _i4.AppSettingsState(
          status: gh<_i4.AppSettingStatus>(),
          action: gh<_i4.AppSettingAction>(),
          errorMessage: gh<String>(),
          profileAuthenticated: gh<_i5.Profile>(),
        ));
    gh.factory<_i6.AppbarCubit>(() => _i6.AppbarCubit());
    gh.factory<_i6.AppbarState>(() => _i6.AppbarState(
          onShowSmallTextField: gh<bool>(),
          status: gh<_i6.AppbarStatus>(),
        ));
    gh.factory<_i7.AuthFormCubit>(() => _i7.AuthFormCubit());
    gh.factory<_i8.AuthRepository>(() => _i8.AuthRepository());
    gh.factory<_i9.AuthenticationBloc>(
        () => _i9.AuthenticationBloc(gh<_i8.AuthRepository>()));
    gh.factory<_i9.AuthenticationState>(() => _i9.AuthenticationState(
          isLoading: gh<bool>(),
          isSuccess: gh<bool>(),
          status: gh<_i9.AuthenticationStatus>(),
          action: gh<_i9.AuthenticationAction>(),
          isError: gh<bool>(),
          errorMessage: gh<String>(),
        ));
    gh.factory<_i10.DetailRepository>(() => _i10.DetailRepository());
    gh.factory<_i11.HelpCubit>(() => _i11.HelpCubit());
    gh.factory<_i12.HomeCubit>(() => _i12.HomeCubit());
    gh.factory<_i12.HomeState>(
        () => _i12.HomeState(status: gh<_i12.HomeStatus>()));
    gh.factory<_i13.ReportCubit>(
        () => _i13.ReportCubit(gh<_i10.DetailRepository>()));
    gh.factory<_i14.ResetPasswordCubit>(
        () => _i14.ResetPasswordCubit(gh<_i8.AuthRepository>()));
    gh.factory<_i15.ReviewCubit>(
        () => _i15.ReviewCubit(gh<_i10.DetailRepository>()));
    gh.factory<_i16.ReviewItemCubit>(
        () => _i16.ReviewItemCubit(gh<_i10.DetailRepository>()));
    gh.factory<_i17.SearchRepository>(() => _i17.SearchRepository());
    gh.factory<_i18.SelectProvinceCubit>(() => _i18.SelectProvinceCubit());
    gh.lazySingleton<_i19.StorageProvider>(
        () => _i19.StorageProvider(gh<_i20.FlutterSecureStorage>()));
    gh.factory<_i21.UserRepository>(() => _i21.UserRepository());
    gh.factory<_i22.AddUniversityCubit>(
        () => _i22.AddUniversityCubit(gh<_i10.DetailRepository>()));
    gh.factory<_i4.AppSettingsBloc>(
        () => _i4.AppSettingsBloc(gh<_i21.UserRepository>()));
    gh.factory<_i23.AutocompletionCubit>(
        () => _i23.AutocompletionCubit(gh<_i17.SearchRepository>()));
    gh.factory<_i24.CompareCubit>(
        () => _i24.CompareCubit(gh<_i10.DetailRepository>()));
    gh.factory<_i25.DetailCubit>(
        () => _i25.DetailCubit(gh<_i10.DetailRepository>()));
    gh.factory<_i26.ProfileCubit>(
        () => _i26.ProfileCubit(gh<_i21.UserRepository>()));
    gh.factory<_i27.SearchCubit>(
        () => _i27.SearchCubit(gh<_i17.SearchRepository>()));
    return this;
  }
}

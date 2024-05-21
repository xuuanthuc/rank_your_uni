// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i23;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template/global/storage/storage_provider.dart' as _i22;
import 'package:template/src/dashboard/bloc/account/dashboard_account_item_cubit.dart'
    as _i29;
import 'package:template/src/dashboard/bloc/authenticate/dashboard_authentication_cubit.dart'
    as _i30;
import 'package:template/src/dashboard/bloc/contact/dashboard_contact_item_cubit.dart'
    as _i31;
import 'package:template/src/dashboard/bloc/dashboard_cubit.dart' as _i32;
import 'package:template/src/dashboard/bloc/professor/dashboard_professor_item_cubit.dart'
    as _i33;
import 'package:template/src/dashboard/bloc/report/dashboard_report_item_cubit.dart'
    as _i34;
import 'package:template/src/dashboard/bloc/university/dashboard_university_item_cubit.dart'
    as _i11;
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart'
    as _i9;
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart'
    as _i4;
import 'package:template/src/models/response/profile.dart' as _i5;
import 'package:template/src/network/api_provider.dart' as _i3;
import 'package:template/src/repositories/auth_repository.dart' as _i8;
import 'package:template/src/repositories/dashboard_repository.dart' as _i10;
import 'package:template/src/repositories/detail_repository.dart' as _i12;
import 'package:template/src/repositories/search_repository.dart' as _i19;
import 'package:template/src/repositories/user_repository.dart' as _i25;
import 'package:template/src/screens/add/bloc/add_cubit.dart' as _i26;
import 'package:template/src/screens/add/bloc/select_province_cubit.dart'
    as _i20;
import 'package:template/src/screens/add/bloc/select_university_cubit.dart'
    as _i21;
import 'package:template/src/screens/appbar/bloc/appbar_cubit.dart' as _i6;
import 'package:template/src/screens/authentication/bloc/auth_form_cubit.dart'
    as _i7;
import 'package:template/src/screens/compare/bloc/compare_cubit.dart' as _i28;
import 'package:template/src/screens/detail/bloc/detail_professor_cubit.dart'
    as _i35;
import 'package:template/src/screens/detail/bloc/detail_university_cubit.dart'
    as _i13;
import 'package:template/src/screens/detail/bloc/professor_review_item_cubit.dart'
    as _i15;
import 'package:template/src/screens/detail/bloc/report_cubit.dart' as _i16;
import 'package:template/src/screens/detail/bloc/university_review_item_cubit.dart'
    as _i24;
import 'package:template/src/screens/guideline/bloc/help_cubit.dart' as _i36;
import 'package:template/src/screens/home/bloc/home_cubit.dart' as _i14;
import 'package:template/src/screens/profile/bloc/profile_cubit.dart' as _i37;
import 'package:template/src/screens/reset/bloc/reset_password_cubit.dart'
    as _i17;
import 'package:template/src/screens/review/bloc/review_cubit.dart' as _i18;
import 'package:template/src/screens/search/bloc/search_cubit.dart' as _i38;
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart'
    as _i27;

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
          type: gh<_i4.SearchType>(),
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
    gh.factory<_i10.DashboardRepository>(() => _i10.DashboardRepository());
    gh.factory<_i11.DashboardUniversityItemCubit>(() =>
        _i11.DashboardUniversityItemCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i12.DetailRepository>(() => _i12.DetailRepository());
    gh.factory<_i13.DetailUniversityCubit>(
        () => _i13.DetailUniversityCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i14.HomeCubit>(() => _i14.HomeCubit());
    gh.factory<_i14.HomeState>(
        () => _i14.HomeState(status: gh<_i14.HomeStatus>()));
    gh.factory<_i15.ProfessorReviewItemCubit>(
        () => _i15.ProfessorReviewItemCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i16.ReportCubit>(
        () => _i16.ReportCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i17.ResetPasswordCubit>(
        () => _i17.ResetPasswordCubit(gh<_i8.AuthRepository>()));
    gh.factory<_i18.ReviewCubit>(
        () => _i18.ReviewCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i19.SearchRepository>(() => _i19.SearchRepository());
    gh.factory<_i20.SelectProvinceCubit>(() => _i20.SelectProvinceCubit());
    gh.factory<_i21.SelectUniversityCubit>(
        () => _i21.SelectUniversityCubit(gh<_i19.SearchRepository>()));
    gh.lazySingleton<_i22.StorageProvider>(
        () => _i22.StorageProvider(gh<_i23.FlutterSecureStorage>()));
    gh.factory<_i24.UniversityReviewItemCubit>(
        () => _i24.UniversityReviewItemCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i25.UserRepository>(() => _i25.UserRepository());
    gh.factory<_i26.AddCubit>(() => _i26.AddCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i4.AppSettingsBloc>(
        () => _i4.AppSettingsBloc(gh<_i25.UserRepository>()));
    gh.factory<_i27.AutocompletionCubit>(
        () => _i27.AutocompletionCubit(gh<_i19.SearchRepository>()));
    gh.factory<_i28.CompareCubit>(
        () => _i28.CompareCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i29.DashboardAccountItemCubit>(
        () => _i29.DashboardAccountItemCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i30.DashboardAuthenticationCubit>(() =>
        _i30.DashboardAuthenticationCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i31.DashboardContactItemCubit>(
        () => _i31.DashboardContactItemCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i32.DashboardCubit>(
        () => _i32.DashboardCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i33.DashboardProfessorItemCubit>(
        () => _i33.DashboardProfessorItemCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i34.DashboardReportItemCubit>(
        () => _i34.DashboardReportItemCubit(gh<_i10.DashboardRepository>()));
    gh.factory<_i35.DetailProfessorCubit>(
        () => _i35.DetailProfessorCubit(gh<_i12.DetailRepository>()));
    gh.factory<_i36.HelpCubit>(() => _i36.HelpCubit(gh<_i25.UserRepository>()));
    gh.factory<_i37.ProfileCubit>(
        () => _i37.ProfileCubit(gh<_i25.UserRepository>()));
    gh.factory<_i38.SearchCubit>(
        () => _i38.SearchCubit(gh<_i19.SearchRepository>()));
    return this;
  }
}

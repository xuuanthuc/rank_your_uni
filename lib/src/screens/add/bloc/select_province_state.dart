part of 'select_province_cubit.dart';

enum SelectStatus { loading, success, error }

enum SelectedAction { init, selectDistrict }

@immutable
class SelectProvinceState extends Equatable {
  final SelectStatus? status;
  final SelectedAction? action;
  final Province? provinceSelected;
  final Districts? districtSelected;
  final List<Province>? provinces;
  final List<Province>? searchingProvinces;
  final List<Districts>? searchingDistrics;
  final AddUniversityRaw? addUniversityRaw;

  const SelectProvinceState({
    this.status,
    this.action,
    this.provinces,
    this.searchingProvinces,
    this.searchingDistrics,
    this.provinceSelected,
    this.districtSelected,
    this.addUniversityRaw,
  });

  SelectProvinceState copyWith({
    SelectStatus? status,
    SelectedAction? action,
    List<Province>? provinces,
    List<Province>? searchingProvinces,
    List<Districts>? searchingDistrics,
    Province? provinceSelected,
    Districts? districtSelected,
    AddUniversityRaw? addUniversityRaw,
  }) {
    return SelectProvinceState(
      status: status ?? this.status,
      action: action ?? this.action,
      addUniversityRaw: addUniversityRaw ?? this.addUniversityRaw,
      provinces: provinces ?? this.provinces,
      searchingProvinces: searchingProvinces ?? this.searchingProvinces,
      searchingDistrics: searchingDistrics ?? this.searchingDistrics,
      provinceSelected: provinceSelected,
      districtSelected: districtSelected,
    );
  }

  @override
  List<Object?> get props => [
        status,
        action,
        provinces,
        searchingProvinces,
        searchingDistrics,
        provinceSelected,
        districtSelected,
        addUniversityRaw,
      ];
}

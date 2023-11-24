part of 'add_university_cubit.dart';

enum AddUniStatus { loading, success, error }

@immutable
class AddUniversityState extends Equatable {
  final AddUniStatus? status;
  final Province? provinceSelected;
  final Districts? districtSelected;
  final List<Province>? provinces;
  final List<Province>? searchingProvinces;
  final List<Districts>? searchingDistrics;

  const AddUniversityState({
    this.status,
    this.provinces,
    this.searchingProvinces,
    this.searchingDistrics,
    this.provinceSelected,
    this.districtSelected,
  });

  AddUniversityState copyWith({
    AddUniStatus? status,
    List<Province>? provinces,
    List<Province>? searchingProvinces,
    List<Districts>? searchingDistrics,
    Province? provinceSelected,
    Districts? districtSelected,
  }) {
    return AddUniversityState(
      status: status ?? this.status,
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
        provinces,
        searchingProvinces,
        searchingDistrics,
        provinceSelected,
        districtSelected,
      ];
}

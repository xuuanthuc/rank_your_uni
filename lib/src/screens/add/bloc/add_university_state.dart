part of 'add_university_cubit.dart';

enum AddUniStatus { loading, success, error }

@immutable
class AddUniversityState extends Equatable {
  final AddUniStatus? status;
  final AddUniversityRaw? addUniversityRaw;
  final bool? acceptPrivacy;

  const AddUniversityState({
    this.status,
    this.addUniversityRaw,
    this.acceptPrivacy,
  });

  AddUniversityState copyWith({
    AddUniStatus? status,
    AddUniversityRaw? addUniversityRaw,
    bool? acceptPrivacy,
  }) {
    return AddUniversityState(
      status: status ?? this.status,
      addUniversityRaw: addUniversityRaw ?? this.addUniversityRaw,
      acceptPrivacy: acceptPrivacy ?? this.acceptPrivacy,
    );
  }

  @override
  List<Object?> get props => [
        status,
        addUniversityRaw,
        acceptPrivacy,
      ];
}

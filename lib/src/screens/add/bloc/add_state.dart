part of 'add_cubit.dart';

enum AddStatus { loading, changed, error, success }

@immutable
class AddState extends Equatable {
  final AddStatus? status;
  final AddUniversityRaw? addUniversityRaw;
  final bool? acceptPrivacy;

  const AddState({
    this.status,
    this.addUniversityRaw,
    this.acceptPrivacy,
  });

  AddState copyWith({
    AddStatus? status,
    AddUniversityRaw? addUniversityRaw,
    bool? acceptPrivacy,
  }) {
    return AddState(
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

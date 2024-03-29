part of 'add_cubit.dart';

enum AddStatus { loading, changed, error, success }

@immutable
class AddState extends Equatable {
  final AddStatus? status;
  final AddUniversityRaw? addUniversityRaw;
  final bool? acceptPrivacy;
  final String? message;

  const AddState({
    this.status,
    this.addUniversityRaw,
    this.acceptPrivacy,
    this.message,
  });

  AddState copyWith({
    AddStatus? status,
    AddUniversityRaw? addUniversityRaw,
    bool? acceptPrivacy,
    String? message,
  }) {
    return AddState(
      status: status ?? this.status,
      addUniversityRaw: addUniversityRaw ?? this.addUniversityRaw,
      acceptPrivacy: acceptPrivacy ?? this.acceptPrivacy,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        addUniversityRaw,
        acceptPrivacy,
        message,
      ];
}

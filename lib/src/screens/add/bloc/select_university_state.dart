part of 'select_university_cubit.dart';

@immutable
class SelectUniversityState extends Equatable {
  final University? university;
  final List<Major>? majors;
  final Major? major;

  const SelectUniversityState({
    this.university,
    this.major,
    this.majors,
  });

  SelectUniversityState copyWith({
    University? university,
    List<Major>? majors,
    Major? major,
  }) {
    return SelectUniversityState(
      university: university ?? this.university,
      majors: majors ?? this.majors,
      major: major ?? this.major,
    );
  }

  @override
  List<Object?> get props => [
        university,
        major,
        majors,
      ];
}

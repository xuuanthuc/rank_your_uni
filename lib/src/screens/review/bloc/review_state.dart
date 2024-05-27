part of 'review_cubit.dart';

enum ReviewStatus { success, error, loading, deleteSuccess }

enum ReviewAction { delete, update }

enum ReviewMode { create, edit }

@immutable
class ReviewState extends Equatable {
  final ReviewStatus? status;
  final ReviewAction? action;
  final ReviewMode? mode;
  final University? university;
  final String? contentRated;
  final int? reputation;
  final int? internet;
  final int? location;
  final int? facilities;
  final int? food;
  final int? clubs;
  final int? favorite;
  final int? competition;
  final int? pedagogical;
  final int? professional;
  final int? hard;
  final Professor? professor;
  final List<Tag>? tags;
  final List<Tag>? selectedTags;
  final bool? hardAttendance;
  final bool? reLearn;
  final String? point;
  final String? courseName;
  final DateTime? modifiedAt;

  const ReviewState({
    this.contentRated,
    this.reputation,
    this.internet,
    this.location,
    this.facilities,
    this.food,
    this.clubs,
    this.favorite,
    this.competition,
    this.status,
    this.university,
    this.mode,
    this.action,
    this.professor,
    this.hard,
    this.professional,
    this.pedagogical,
    this.courseName,
    this.point,
    this.reLearn,
    this.hardAttendance,
    this.tags,
    this.selectedTags,
    this.modifiedAt,
  });

  ReviewState copyWith({
    ReviewStatus? status,
    ReviewAction? action,
    ReviewMode? mode,
    University? university,
    Professor? professor,
    String? contentRated,
    int? reputation,
    int? internet,
    int? location,
    int? facilities,
    int? food,
    int? clubs,
    int? favorite,
    int? competition,
    int? schoolId,
    int? pedagogical,
    int? professional,
    int? hard,
    bool? hardAttendance,
    bool? reLearn,
    String? point,
    String? courseName,
    List<Tag>? tags,
    List<Tag>? selectedTags,
    DateTime? modifiedAt,
  }) {
    return ReviewState(
      status: status ?? this.status,
      university: university ?? this.university,
      professor: professor ?? this.professor,
      reputation: reputation ?? this.reputation,
      clubs: clubs ?? this.clubs,
      competition: competition ?? this.competition,
      contentRated: contentRated ?? this.contentRated,
      internet: internet ?? this.internet,
      location: location ?? this.location,
      facilities: facilities ?? this.facilities,
      food: food ?? this.food,
      favorite: favorite ?? this.favorite,
      mode: mode ?? this.mode,
      pedagogical: pedagogical ?? this.pedagogical,
      professional: professional ?? this.professional,
      hard: hard ?? this.hard,
      point: point ?? this.point,
      hardAttendance: hardAttendance ?? this.hardAttendance,
      reLearn: reLearn ?? this.reLearn,
      courseName: courseName ?? this.courseName,
      tags: tags ?? this.tags,
      selectedTags: selectedTags ?? this.selectedTags,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      action: action,
    );
  }

  @override
  List<Object?> get props => [
        university,
        professor,
        contentRated,
        reputation,
        internet,
        location,
        facilities,
        food,
        clubs,
        favorite,
        competition,
        status,
        mode,
        action,
        pedagogical,
        professional,
        hard,
        courseName,
        point,
        hardAttendance,
        reLearn,
        tags,
        selectedTags,
        modifiedAt,
      ];
}

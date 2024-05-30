import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/add_university_request.dart';
import 'package:template/src/models/request/report_request.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/professor_review.dart';
import 'package:template/src/models/response/response.dart';
import 'package:template/src/models/response/university_review.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/network/exception.dart';
import '../models/request/add_professor_request.dart';
import '../models/response/tag.dart';
import './../../src/network/endpoint.dart';
import '../di/dependencies.dart';
import '../network/api_provider.dart';

@injectable
@lazySingleton
class DetailRepository {
  final ApiProvider _apiProvider = getIt.get<ApiProvider>();

  Future<RYUResponse> getDetailUniversity(int id) async {
    try {
      final res = await _apiProvider.get(
        '${ApiEndpoint.search}/$id',
      );
      return RYUResponse(isSuccess: true, data: University.fromDetailJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> getDetailProfessor(int id) async {
    try {
      final res = await _apiProvider.get(
        '${ApiEndpoint.professors}/$id',
      );
      return RYUResponse(isSuccess: true, data: Professor.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> reviewUniversity(ReviewUniversityRaw review) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.reviews,
        params: review.toJson(),
      );
      return RYUResponse(isSuccess: true, data: UniversityReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> updateReview(ReviewUniversityRaw review, int id) async {
    try {
      Map<String, dynamic> data = <String, dynamic>{};
      data = review.toJson();
      data['id'] = id;
      final res = await _apiProvider.patch(
        '${ApiEndpoint.reviews}/$id',
        params: data,
      );
      return RYUResponse(isSuccess: true, data: UniversityReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> reviewProfessor(ReviewProfessorRaw review) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.reviewTeacher,
        params: review.toJson(),
      );
      return RYUResponse(isSuccess: true, data: ProfessorReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> updateProfessorReview(
      ReviewProfessorRaw review, int id) async {
    try {
      Map<String, dynamic> data = <String, dynamic>{};
      data = review.toJson();
      data['id'] = id;
      final res = await _apiProvider.put(
        '${ApiEndpoint.reviewTeacher}/$id',
        params: data,
      );
      return RYUResponse(isSuccess: true, data: ProfessorReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> deleteUniversityReview(int id) async {
    try {
      final res = await _apiProvider.delete('${ApiEndpoint.reviews}/$id');
      return RYUResponse(isSuccess: true, data: res);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> deleteProfessorReview(int id) async {
    try {
      final res = await _apiProvider.delete('${ApiEndpoint.reviewTeacher}/$id');
      return RYUResponse(isSuccess: true, data: res);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<bool> reportReview(ReportRaw report) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.report,
        params: report.toJson(),
        needToken: false,
      );
      if (res != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RYUResponse> likeUniversityReview(int id, int userId) async {
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {
          "likedStatus": 1,
          "id": id,
          "userId": userId,
        },
      );
      return RYUResponse(isSuccess: true, data: UniversityReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> dislikeUniversityReview(int id, int userId) async {
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {
          "likedStatus": 2,
          "id": id,
          "userId": userId,
        },
      );
      return RYUResponse(isSuccess: true, data: UniversityReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> undoUniversityReview(int id, int userId) async {
    //cancel like, cancel dislike
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviews}/$id",
        params: {
          "likedStatus": 0,
          "id": id,
          "userId": userId,
        },
      );
      return RYUResponse(isSuccess: true, data: UniversityReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> addUniversity(AddUniversityRaw university) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.search,
        params: university.toJson(),
        needToken: false,
      );
      return RYUResponse(isSuccess: true, data: res);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> addProfessor(AddProfessorRaw professor) async {
    try {
      final res = await _apiProvider.post(
        ApiEndpoint.professor,
        params: professor.toJson(),
        needToken: false,
      );
      return RYUResponse(isSuccess: true, data: res);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> likeProfessorReview(int id, int userId) async {
    try {
      final res = await _apiProvider.put(
        // ApiEndpoint.reviewDetail,
        "${ApiEndpoint.reviewDetail}?reviewTeacherId=$id&userId=$userId&liked=1",
        // params: {
        //   "liked": 1,
        //   "reviewTeacherId": id,
        //   "userId": userId,
        // },
      );
      return RYUResponse(isSuccess: true, data: ProfessorReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> dislikeProfessorReview(int id, int userId) async {
    try {
      final res = await _apiProvider.put(
        // ApiEndpoint.reviewDetail,
        "${ApiEndpoint.reviewDetail}?reviewTeacherId=$id&userId=$userId&liked=2",
        // params: {
        //   "liked": 2,
        //   "reviewTeacherId": id,
        //   "userId": userId,
        // },
      );
      return RYUResponse(isSuccess: true, data: ProfessorReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> undoProfessorReview(int id, int userId) async {
    //cancel like, cancel dislike
    try {
      final res = await _apiProvider.put(
        "${ApiEndpoint.reviewDetail}?reviewTeacherId=$id&userId=$userId&liked=0",
        // params: {
        //   "liked": 0,
        //   "reviewTeacherId": id,
        //   "userId": userId,
        // },
      );
      return RYUResponse(isSuccess: true, data: ProfessorReview.fromJson(res));
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }

  Future<RYUResponse> getProfessorTags() async {
    try {
      final res = await _apiProvider.get(ApiEndpoint.tags);

      final List<Tag> tags = [];
      for (var element in (res['listItem'] as List<dynamic>)) {
        tags.add(Tag.fromJson(element));
      }
      return RYUResponse(isSuccess: true, data: tags);
    } on ResponseException catch (e) {
      return RYUResponse(isSuccess: false, errorMessage: e.title, code: e.code);
    }
  }
}

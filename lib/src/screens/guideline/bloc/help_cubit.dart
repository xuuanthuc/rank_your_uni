import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../models/response/question.dart';

part 'help_state.dart';

@injectable
class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(const HelpState(currentCategory: 0));

  Future<void> getQuestions() async {
    List<QuestionCategories> categories = [];
    const releasePath = kDebugMode ? '' : 'assets/';
    final String response = await rootBundle.loadString('${releasePath}json/questions.json');
    final data = await json.decode(response);
    data.forEach((e) {
      categories.add(QuestionCategories.fromJson(e));
    });
    emit(state.copyWith(categories: categories));
  }

  void changeCategory(int indexPage) {
    emit(state.copyWith(currentCategory: indexPage));
  }

  void showAnswer(int currentIndex) {
    emit(state.copyWith(currentShowIndex: currentIndex));
  }
}

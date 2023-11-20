import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/enum/criteria.dart';
import '../../../../global/enum/rating_point.dart';

part 'item_criteria_state.dart';

class ItemCriteriaCubit extends Cubit<ItemCriteriaState> {
  ItemCriteriaCubit()
      : super(const ItemCriteriaState(status: MouseStatus.none));

  void onStartHover(int index) {
    emit(state.copyWith(status: MouseStatus.hover, indexHover: index, rated: state.rated));
  }

  void onEndHover() {
    emit(state.copyWith(status: MouseStatus.none, indexHover: 0, rated:  state.rated));
  }

  void onRate(CriteriaRated rated) {
    if(rated.point == state.rated?.point) {
      // emit(state.copyWith(status: MouseStatus.hover, rated: null));
    } else {
      emit(state.copyWith(status: MouseStatus.none, rated: rated));
    }
  }
}

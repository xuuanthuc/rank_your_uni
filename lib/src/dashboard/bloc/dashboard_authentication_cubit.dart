import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../../../global/style/app_images.dart';

part 'dashboard_authentication_state.dart';

@injectable
class DashboardAuthenticationCubit extends Cubit<DashboardAuthenticationState> {
  DashboardAuthenticationCubit() : super(const DashboardAuthenticationState());

  void onHover(bool isHovering) {
    emit(state.copyWith(isHovering: isHovering));
  }

  void onStartBackground(VideoPlayerController controller) async {
    await controller.initialize();
    await controller.setVolume(0);
    await controller.setLooping(true);
    await controller.play();
    emit(state.copyWith(videoPlayerController: controller));
  }
}

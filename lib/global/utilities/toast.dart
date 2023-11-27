import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/global/style/app_images.dart';

enum ToastType { success, error, warning }

void appToast(
  BuildContext context, {
  required String message,
  String? subMessage,
  ToastGravity? gravity = ToastGravity.TOP_RIGHT,
  ToastType? type = ToastType.error,
}) {
  FToast fToast = FToast();
  fToast.init(context);
  final theme = Theme.of(context);
  Widget toast = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: type == ToastType.error ? AppColors.error : AppColors.success,
    ),
    child: IntrinsicHeight(
      child: Row(
        children: [
          IntrinsicWidth(
            child: Container(
              width: 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: AppColors.level2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset(AppImages.iWarning),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style:
                    theme.textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
              Text(
                subMessage ?? '',
                style: theme.primaryTextTheme.bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(width: 20)
        ],
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: gravity,
    toastDuration: const Duration(seconds: 5),
  );
}

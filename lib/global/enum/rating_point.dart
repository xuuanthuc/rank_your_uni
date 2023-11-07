import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../style/app_images.dart';

enum RatePoint {
  awful,
  bad,
  medium,
  good,
  excellent,
}

extension RateExt on RatePoint {
  String name(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    switch (this) {
      case RatePoint.awful:
        return text.awful;
      case RatePoint.bad:
        return text.bad;
      case RatePoint.medium:
        return text.medium;
      case RatePoint.good:
        return text.good;
      case RatePoint.excellent:
        return text.excellent;
      default:
        return '';
    }
  }

  String get iconPath {
    switch (this) {
      case RatePoint.awful:
        return AppImages.iAwful;
      case RatePoint.bad:
        return AppImages.iBad;
      case RatePoint.medium:
        return AppImages.iMedium;
      case RatePoint.good:
        return AppImages.iGood;
      case RatePoint.excellent:
        return AppImages.iExcellent;
      default:
        return '';
    }
  }
}

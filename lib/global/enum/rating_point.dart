import 'package:flutter/material.dart';
import 'package:template/global/enum/criteria.dart';

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
  String name(BuildContext context, Criteria crit) {
    final text = AppLocalizations.of(context)!;
    if (crit == Criteria.hard) {
      switch (this) {
        case RatePoint.awful:
          return text.easyAsPie;
        case RatePoint.bad:
          return text.easy;
        case RatePoint.medium:
          return text.medium;
        case RatePoint.good:
          return text.difficult;
        case RatePoint.excellent:
          return text.painful;
        default:
          return '';
      }
    } else {
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
  }

  String iconPath(Criteria crit) {
    if (crit == Criteria.hard) {
      switch (this) {
        case RatePoint.awful:
          return AppImages.iExcellent;
        case RatePoint.bad:
          return AppImages.iGood;
        case RatePoint.medium:
          return AppImages.iMedium;
        case RatePoint.good:
          return AppImages.iBad;
        case RatePoint.excellent:
          return AppImages.iAwful;
        default:
          return '';
      }
    } else {
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
}

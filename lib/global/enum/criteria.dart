import 'package:flutter/cupertino.dart';
import 'package:template/global/style/styles.dart';

enum Criteria {
  reputation,
  competition,
  location,
  internet,
  favorite,
  infrastructure,
  clubs,
  food
}

extension CriteriaName on Criteria {
  String name(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    switch (this) {
      case Criteria.competition:
        return text.competitionLevel;
      case Criteria.reputation:
        return text.reputation;
      case Criteria.location:
        return text.location;
      case Criteria.internet:
        return text.internet;
      case Criteria.favorite:
        return text.favorite;
      case Criteria.infrastructure:
        return text.infrastructure;
      case Criteria.clubs:
        return text.clubs;
      case Criteria.food:
        return text.food;
      default:
        return '';
    }
  }

  String description(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    switch (this) {
      case Criteria.competition:
        return text.competitionDescription;
      case Criteria.reputation:
        return text.reputationDescription;
      case Criteria.location:
        return text.locationDescription;
      case Criteria.internet:
        return text.internetDescription;
      case Criteria.favorite:
        return text.favoriteDescription;
      case Criteria.infrastructure:
        return text.infrastructureDescription;
      case Criteria.clubs:
        return text.clubsDescription;
      case Criteria.food:
        return text.foodDescription;
      default:
        return '';
    }
  }

  String subDescription(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    switch (this) {
      case Criteria.competition:
        return text.competitionSubDescription;
      case Criteria.reputation:
        return text.reputationSubDescription;
      case Criteria.location:
        return text.locationSubDescription;
      case Criteria.internet:
        return text.internetSubDescription;
      case Criteria.favorite:
        return text.favoriteSubDescription;
      case Criteria.infrastructure:
        return text.infrastructureSubDescription;
      case Criteria.clubs:
        return text.clubsSubDescription;
      case Criteria.food:
        return text.foodSubDescription;
      default:
        return '';
    }
  }

  String get iconPath {
    switch (this) {
      case Criteria.competition:
        return AppImages.iCompete;
      case Criteria.reputation:
        return AppImages.iReputation;
      case Criteria.location:
        return AppImages.iLocation;
      case Criteria.internet:
        return AppImages.iInternet;
      case Criteria.favorite:
        return AppImages.iHeart;
      case Criteria.infrastructure:
        return AppImages.iFacilities;
      case Criteria.clubs:
        return AppImages.iClubs;
      case Criteria.food:
        return AppImages.iFood;
      default:
        return '';
    }
  }
}

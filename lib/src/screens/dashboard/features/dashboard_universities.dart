import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/dashboard/bloc/dashboard_cubit.dart';
import 'package:template/src/screens/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../widgets/point_container.dart';

class DashboardUniversities extends StatelessWidget {
  const DashboardUniversities({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardTitle(title: text.university),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                text.universityName,
                style: theme.primaryTextTheme.labelLarge,
              ),
              Container(
                height: 30,
                width: 1,
                color: AppColors.primaryShadow,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Text(
                text.status,
                textAlign: TextAlign.center,
                style: theme.primaryTextTheme.bodyMedium,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => Container(
                  height: 1,
                  color: AppColors.primaryShadow,
                ),
                itemBuilder: (context, index) {
                  final university = (state.universities ?? [])[index];
                  return ItemUniverSity(university: university);
                },
                itemCount: state.universities?.length ?? 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemUniverSity extends StatelessWidget {
  final University university;

  const ItemUniverSity({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              university.id.toString(),
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: PointContainer.tiny(point: university.averagePointAllReviews ?? 0),
          ),
          Expanded(
            child: Text(
              university.name ?? '',
            ),
          ),
          SizedBox(
            width: ResponsiveBuilder.setSize(
              context,
              extraSize: 110,
              smallSize: 20,
            ),
            child: ResponsiveBuilder(
              smallView: Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: university.status == 1
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: university.status == 1
                          ? AppColors.success
                          : AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    university.status == 1 ? text.approved : text.requesting,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
          PopupMenuButton(
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  text.edit,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  text.reject,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
            ],
            onSelected: (n) {},
          ),
        ],
      ),
    );
  }
}

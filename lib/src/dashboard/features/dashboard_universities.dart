import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/university/dashboard_university_item_cubit.dart';
import 'package:template/src/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/dashboard/features/widget/header_line.dart';
import 'package:template/src/dashboard/features/widget/university_detail_dialog.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/loading.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/utilities/toast.dart';
import '../../screens/widgets/point_container.dart';
import '../bloc/dashboard_cubit.dart';

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
              Expanded(
                child: Text(
                  text.universityName,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
              const HeaderLine(),
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
            if (state.status == DashboardStatus.loading) {
              return Expanded(
                child: Center(
                  child: PrimaryCircularLoading(
                    state.status == DashboardStatus.loading,
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => Container(
                  height: 1,
                  color: AppColors.primaryShadow,
                ),
                itemBuilder: (context, index) {
                  final university = (state.universities ?? [])[index];
                  return BlocProvider(
                    create: (context) =>
                        getIt.get<DashboardUniversityItemCubit>(),
                    child: ItemUniverSity(university: university),
                  );
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

class ItemUniverSity extends StatefulWidget {
  final University university;

  const ItemUniverSity({
    super.key,
    required this.university,
  });

  @override
  State<ItemUniverSity> createState() => _ItemUniverSityState();
}

class _ItemUniverSityState extends State<ItemUniverSity> {
  @override
  void initState() {
    super.initState();
    context
        .read<DashboardUniversityItemCubit>()
        .getUniversity(widget.university);
  }

  void _showUniversityDetailDialog(
    BuildContext context,
    University university,
  ) {
    showDialog<University?>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<DashboardUniversityItemCubit>(),
          child: UniversityDetailDialog(university: university),
        );
      },
    ).then((value) {
      if (value != null) {
        context.read<DashboardUniversityItemCubit>().getUniversity(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocListener<DashboardUniversityItemCubit,
        DashboardUniversityItemState>(
      listener: (context, state) {
        if (state.status == DashboardUniversityStatus.success) {
          appToast(context,
              message: AppLocalizations.of(context)!.updateSuccess,
              type: ToastType.success);
        } else if (state.status == DashboardUniversityStatus.error) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: state.errorMessage,
          );
        }
      },
      child: BlocBuilder<DashboardUniversityItemCubit,
          DashboardUniversityItemState>(
        builder: (context, state) {
         if (state.university != null) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      state.university!.id.toString(),
                      textAlign: TextAlign.center,
                      style: theme.primaryTextTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: PointContainer.tiny(
                      point: state.university!.averagePointAllReviews ?? 0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.university!.name ?? '',
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
                            color: state.university!.status ==
                                    UniversityStatus.approved
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
                              color: state.university!.status ==
                                      UniversityStatus.approved
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            state.university!.status ==
                                    UniversityStatus.approved
                                ? text.approved
                                : text.requesting,
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
                      if (state.university!.status ==
                          UniversityStatus.requesting)
                        PopupMenuItem(
                          child: Text(
                            text.approve,
                            style: theme.primaryTextTheme.titleLarge,
                          ),
                          onTap: () {
                            context
                                .read<DashboardUniversityItemCubit>()
                                .approveUniversity();
                          },
                        ),
                      PopupMenuItem(
                        child: Text(
                          text.edit,
                          style: theme.primaryTextTheme.titleLarge,
                        ),
                        onTap: () => _showUniversityDetailDialog(
                          context,
                          state.university!,
                        ),
                      ),
                      PopupMenuItem(
                        child: Text(
                          state.university!.status == UniversityStatus.approved
                              ? text.delete
                              : text.reject,
                          style: theme.primaryTextTheme.titleLarge,
                        ),
                        onTap: () {
                          context
                              .read<DashboardUniversityItemCubit>()
                              .deleteUniversity();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

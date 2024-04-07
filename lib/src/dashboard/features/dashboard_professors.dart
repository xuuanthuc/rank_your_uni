import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/professor/dashboard_professor_item_cubit.dart';
import 'package:template/src/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/dashboard/features/widget/header_line.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/screens/widgets/loading.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/utilities/toast.dart';
import '../../screens/widgets/point_container.dart';
import '../bloc/dashboard_cubit.dart';

class DashboardProfessors extends StatelessWidget {
  const DashboardProfessors({super.key});

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
                  final professor = (state.professors ?? [])[index];
                  return BlocProvider(
                    create: (context) =>
                        getIt.get<DashboardProfessorItemCubit>(),
                    child: ItemProfessor(professor: professor),
                  );
                },
                itemCount: state.professors?.length ?? 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemProfessor extends StatefulWidget {
  final Professor professor;

  const ItemProfessor({
    super.key,
    required this.professor,
  });

  @override
  State<ItemProfessor> createState() => _ItemProfessorState();
}

class _ItemProfessorState extends State<ItemProfessor> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardProfessorItemCubit>().getProfessors(widget.professor);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocListener<DashboardProfessorItemCubit,
        DashboardProfessorItemState>(
      listener: (context, state) {
        if (state.status == DashboardProfessorStatus.success) {
          appToast(context,
              message: AppLocalizations.of(context)!.updateSuccess,
              type: ToastType.success);
        } else if (state.status == DashboardProfessorStatus.error) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: state.errorMessage,
          );
        }
      },
      child:
          BlocBuilder<DashboardProfessorItemCubit, DashboardProfessorItemState>(
        builder: (context, state) {
          if (state.professor != null) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      state.professor!.id.toString(),
                      textAlign: TextAlign.center,
                      style: theme.primaryTextTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: PointContainer.tiny(
                      point: 0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.professor!.fullName ?? '',
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
                            color: state.professor!.status ==
                                    ProfessorStatus.approved
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
                              color: state.professor!.status ==
                                      ProfessorStatus.approved
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            state.professor!.status == ProfessorStatus.approved
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
                      if (state.professor!.status ==
                          ProfessorStatus.requesting)
                        PopupMenuItem(
                          child: Text(
                            text.approve,
                            style: theme.primaryTextTheme.titleLarge,
                          ),
                          onTap: () {
                            context
                                .read<DashboardProfessorItemCubit>()
                                .approveProfessor();
                          },
                        ),
                      PopupMenuItem(
                        child: Text(
                          text.edit,
                          style: theme.primaryTextTheme.titleLarge,
                        ),
                        onTap: () => {}
                      ),
                      PopupMenuItem(
                        child: Text(
                          state.professor!.status == ProfessorStatus.approved
                              ? text.delete
                              : text.reject,
                          style: theme.primaryTextTheme.titleLarge,
                        ),
                        onTap: () {

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

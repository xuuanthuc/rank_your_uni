import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/tags/dashboard_tag_item_cubit.dart';
import 'package:template/src/dashboard/features/widget/add_tag_dialog.dart';
import 'package:template/src/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/dashboard/features/widget/header_line.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/tag.dart';
import 'package:template/src/screens/widgets/loading.dart';
import '../../../global/utilities/toast.dart';
import '../../screens/widgets/responsive_builder.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/tags/dashboard_tags_cubit.dart';

class DashboardTags extends StatelessWidget {
  const DashboardTags({super.key});

  void _showAddTagDialog(BuildContext context) {
    showDialog<String?>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const AddTagDialog();
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        context.read<DashboardTagsCubit>().addNewTag(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardTitle(title: text.teacherTags),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text.teacherTags,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
              const HeaderLine(),
              IconButton(
                onPressed: () => _showAddTagDialog(context),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary)),
                icon: ResponsiveBuilder(
                  smallView: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        AppLocalizations.of(context)!.addTag,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                ),
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
                  final tag = (state.tags ?? [])[index];
                  return BlocProvider(
                    create: (context) => getIt.get<DashboardTagItemCubit>(),
                    child: ItemTag(tag: tag),
                  );
                },
                itemCount: state.tags?.length ?? 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemTag extends StatefulWidget {
  final Tag tag;

  const ItemTag({
    super.key,
    required this.tag,
  });

  @override
  State<ItemTag> createState() => _ItemTagState();
}

class _ItemTagState extends State<ItemTag> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardTagItemCubit>().getTag(widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocListener<DashboardTagItemCubit, DashboardTagItemState>(
      listener: (context, state) {
        if (state.status == DashboardTagItemStatus.success) {
          appToast(context,
              message: AppLocalizations.of(context)!.updateSuccess,
              type: ToastType.success);
        } else if (state.status == DashboardTagItemStatus.error) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: "state.errorMessage",
          );
        }
      },
      child: BlocBuilder<DashboardTagItemCubit, DashboardTagItemState>(
        builder: (context, state) {
          if (state.tag != null) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      state.tag!.id.toString(),
                      textAlign: TextAlign.center,
                      style: theme.primaryTextTheme.titleLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.tag?.label ?? '',
                    ),
                  ),
                  const SizedBox(width: 4),
                  PopupMenuButton(
                    color: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    itemBuilder: (context) => [],
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

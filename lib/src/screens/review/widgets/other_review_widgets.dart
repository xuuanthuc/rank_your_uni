import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../global/style/styles.dart';
import '../bloc/review_cubit.dart';

enum YesNo { yes, no, none }

extension YesNoQuestion on YesNo {
  String label(AppLocalizations text) {
    switch (this) {
      case YesNo.yes:
        return text.yes;
      case YesNo.no:
        return text.no;
      case YesNo.none:
        return '';
    }
  }

  bool? get value {
    switch (this) {
      case YesNo.yes:
        return true;
      case YesNo.no:
        return false;
      case YesNo.none:
        return null;
    }
  }
}

class ReviewTextEditting extends StatelessWidget {
  final TextEditingController controller;

  const ReviewTextEditting({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.academicYear,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '*',
                  style: theme.primaryTextTheme.labelLarge?.copyWith(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 8),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.yourAcademicYear,
                    style: theme.primaryTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  maxLength: 30,
                  controller: controller,
                  onChanged: (value) {
                    if (value.length > 30) return;
                    context.read<ReviewCubit>().updateCourseName(value);
                  },
                  decoration: InputDecoration(
                    hintText: text.k69,
                    hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                      color: AppColors.textGrey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ReviewHardAttendance extends StatelessWidget {
  const ReviewHardAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.attendancion,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Radio<bool?>(
                                  value: YesNo.no.value,
                                  groupValue: state.hardAttendance,
                                  onChanged: (value) {
                                    context
                                        .read<ReviewCubit>()
                                        .updateHardAttendance(value ?? false);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                YesNo.yes.label(text),
                                style: theme.primaryTextTheme.bodyMedium,
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Radio<bool?>(
                                  value: YesNo.yes.value,
                                  groupValue: state.hardAttendance,
                                  onChanged: (value) {
                                    context
                                        .read<ReviewCubit>()
                                        .updateHardAttendance(value ?? true);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                YesNo.no.label(text),
                                style: theme.primaryTextTheme.bodyMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ReviewRelearn extends StatelessWidget {
  const ReviewRelearn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.wannaRelearn,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Radio<bool?>(
                                  value: YesNo.no.value,
                                  groupValue: state.reLearn,
                                  onChanged: (value) {
                                    context
                                        .read<ReviewCubit>()
                                        .updateRelearn(value ?? false);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                YesNo.yes.label(text),
                                style: theme.primaryTextTheme.bodyMedium,
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Radio<bool?>(
                                  value: YesNo.yes.value,
                                  groupValue: state.reLearn,
                                  onChanged: (value) {
                                    context
                                        .read<ReviewCubit>()
                                        .updateRelearn(value ?? true);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                YesNo.no.label(text),
                                style: theme.primaryTextTheme.bodyMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ReviewSemesterPoint extends StatelessWidget {
  const ReviewSemesterPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    final items = [
      "A+",
      "A",
      "B+",
      "B",
      "C",
      "D/F",
      "Trống",
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.yourPoint,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.textGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  state.point ?? text.empty,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: theme.primaryTextTheme.labelLarge,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.primary,
                                  size: 32,
                                )
                              ],
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<ReviewCubit>()
                                .updateSemesterPoint(value ?? "");
                          },
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: theme.primaryTextTheme.labelLarge,
                                    ),
                                  ))
                              .toList(),
                          buttonStyleData: ButtonStyleData(
                            width: 300,
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                          iconStyleData: const IconStyleData(iconSize: 0),
                          dropdownStyleData: DropdownStyleData(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 1,
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: WidgetStateProperty.all(6),
                              thumbVisibility: WidgetStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ReviewTags extends StatelessWidget {
  const ReviewTags({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.teacherTags,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 8),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    text.chooseThreeTags,
                    style: theme.primaryTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 8),
                child: Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: List.generate(
                    (state.tags ?? []).length,
                    (index) {
                      final tag = (state.tags ?? [])[index];
                      return InkWell(
                        onTap: () {
                          context.read<ReviewCubit>().updateTags(tag);
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: (state.selectedTags ?? [])
                                  .any((t) => t.id == tag.id)
                                  ? AppColors.primary
                                  : AppColors.textGrey,
                              width: 1,
                            ),
                            color: (state.selectedTags ?? [])
                                    .any((t) => t.id == tag.id)
                                ? AppColors.primary
                                : Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            tag.label ?? '',
                            style: theme.primaryTextTheme.bodyMedium?.copyWith(
                              color: (state.selectedTags ?? [])
                                      .any((t) => t.id == tag.id)
                                  ? Colors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

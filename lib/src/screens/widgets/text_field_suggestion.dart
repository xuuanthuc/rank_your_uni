import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/routes/route_keys.dart';
import 'bloc/autocompletion_cubit.dart';

//University
class TextFieldUniversitiesAutocompleted extends StatelessWidget {
  final Function(University) onSelected;
  final InputDecoration? inputDecorationCustom;
  final Function(String)? onEditingComplete;

  const TextFieldUniversitiesAutocompleted({
    super.key,
    required this.onSelected,
    this.inputDecorationCustom,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AutocompletionCubit, AutocompletionState>(
      builder: (context, state) {
        return Autocomplete<University>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            final data = await context
                .read<AutocompletionCubit>()
                .getSuggestUniversity(textEditingValue.text);
            return data;
          },
          optionsViewBuilder: (context, onTap, universities) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 400,
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.5 - 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      final uni = universities.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: TextButton(
                          onPressed: () => onSelected(uni),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            overlayColor:
                                MaterialStateProperty.all(AppColors.level4),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: ResponsiveBuilder(
                                smallView: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const IconStudentCap(),
                                          const SizedBox(height: 4),
                                          UniversityName(university: uni),
                                          UniversityAddress(university: uni),
                                          ButtonGoToUniversityDetailPage(
                                            onTap: () {
                                              context.goNamed(
                                                RouteKey.university,
                                                pathParameters: {
                                                  "id": "${uni.id}"
                                                },
                                                extra: uni,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const IconStudentCap(),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UniversityName(university: uni),
                                          UniversityAddress(university: uni),
                                          ButtonGoToUniversityDetailPage(
                                            onTap: () {
                                              context.goNamed(
                                                RouteKey.university,
                                                pathParameters: {
                                                  "id": "${uni.id}"
                                                },
                                                extra: uni,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: universities.length,
                  ),
                ),
              ),
            );
          },
          onSelected: (University selection) {
            onSelected(selection);
          },
          fieldViewBuilder: (context, controller, focusNode, vo) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: theme.primaryTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                if (onEditingComplete != null) {
                  onEditingComplete!(controller.text);
                }
              },
              cursorColor: AppColors.black,
              decoration: inputDecorationCustom ??
                  InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey,
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.findUniversityName,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.transparent,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
            );
          },
        );
      },
    );
  }
}

class UniversityName extends StatelessWidget {
  final University university;

  const UniversityName({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      university.name ?? '',
      style: theme.primaryTextTheme.labelLarge,
    );
  }
}

class UniversityAddress extends StatelessWidget {
  final University university;

  const UniversityAddress({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      university.address ?? '',
      style: theme.primaryTextTheme.bodyMedium,
    );
  }
}

class ButtonGoToUniversityDetailPage extends StatelessWidget {
  final Function onTap;

  const ButtonGoToUniversityDetailPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          AppLocalizations.of(context)!.goToUniversityPage,
          style: theme.primaryTextTheme.titleLarge?.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class IconStudentCap extends StatelessWidget {
  const IconStudentCap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: SvgPicture.asset(
        AppImages.iStudentCap,
      ),
    );
  }
}

//professor
class TextFieldProfessorsAutocompleted extends StatelessWidget {
  final Function(Professor) onSelected;
  final InputDecoration? inputDecorationCustom;
  final Function(String)? onEditingComplete;

  const TextFieldProfessorsAutocompleted({
    super.key,
    required this.onSelected,
    this.inputDecorationCustom,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AutocompletionCubit, AutocompletionState>(
      builder: (context, state) {
        return Autocomplete<Professor>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            final data = await context
                .read<AutocompletionCubit>()
                .getSuggestProfessor(textEditingValue.text);
            return data;
          },
          optionsViewBuilder: (context, onTap, professors) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 400,
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.5 - 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      final professor = professors.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: TextButton(
                          onPressed: () => onSelected(professor),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            overlayColor:
                            MaterialStateProperty.all(AppColors.level4),
                            backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: ResponsiveBuilder(
                                smallView: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const IconProfessorTie(),
                                          const SizedBox(height: 4),
                                          ProfessorName(professor: professor),
                                          ProfessorUniversity(professor: professor),
                                          ButtonGoToProfessorDetailPage(
                                            onTap: () {
                                              context.goNamed(
                                                RouteKey.university,
                                                pathParameters: {
                                                  "id": "${professor.id}"
                                                },
                                                extra: professor,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const IconProfessorTie(),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          ProfessorName(professor: professor),
                                          ProfessorUniversity(professor: professor),
                                          ButtonGoToProfessorDetailPage(
                                            onTap: () {
                                              context.goNamed(
                                                RouteKey.university,
                                                pathParameters: {
                                                  "id": "${professor.id}"
                                                },
                                                extra: professor,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: professors.length,
                  ),
                ),
              ),
            );
          },
          onSelected: (Professor selection) {
            onSelected(selection);
          },
          fieldViewBuilder: (context, controller, focusNode, vo) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: theme.primaryTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                if (onEditingComplete != null) {
                  onEditingComplete!(controller.text);
                }
              },
              cursorColor: AppColors.black,
              decoration: inputDecorationCustom ??
                  InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey,
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.findUniversityName,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.transparent,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
            );
          },
        );
      },
    );
  }
}

class ProfessorName extends StatelessWidget {
  final Professor professor;

  const ProfessorName({
    super.key,
    required this.professor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      professor.fullName ?? '',
      style: theme.primaryTextTheme.labelLarge,
    );
  }
}

class ProfessorUniversity extends StatelessWidget {
  final Professor professor;

  const ProfessorUniversity({
    super.key,
    required this.professor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      professor.universityId.toString() ?? '',
      style: theme.primaryTextTheme.bodyMedium,
    );
  }
}

class ButtonGoToProfessorDetailPage extends StatelessWidget {
  final Function onTap;

  const ButtonGoToProfessorDetailPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          AppLocalizations.of(context)!.goToProfessorPage,
          style: theme.primaryTextTheme.titleLarge?.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class IconProfessorTie extends StatelessWidget {
  const IconProfessorTie({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: SvgPicture.asset(
        AppImages.iTie,
      ),
    );
  }
}
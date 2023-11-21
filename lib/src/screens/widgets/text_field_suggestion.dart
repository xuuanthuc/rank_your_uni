import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/university.dart';
import 'bloc/autocompletion_cubit.dart';

class TextFieldAutocompleted extends StatelessWidget {
  final Function(University) onSelected;

  const TextFieldAutocompleted({
    super.key,
    required this.onSelected,
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
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: Public.mobileSize,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      final uni = universities.toList()[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => onSelected(uni),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.iStudentCap),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          uni.name ?? '',
                                          style: theme.primaryTextTheme.labelLarge,
                                        ),
                                        Text(
                                          uni.address ?? '',
                                          style: theme.primaryTextTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.grey,
                  ),
                ),
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

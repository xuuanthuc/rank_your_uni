import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/help_cubit.dart';

class QuestionItem extends StatelessWidget {
  final HelpState state;
  final int pageIndex;
  final int questionIndex;

  const QuestionItem(
    this.state,
    this.pageIndex, {
    Key? key,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              context.read<HelpCubit>().showAnswer(questionIndex);
            },
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  ((state.categories ?? [])[pageIndex].questions ?? [])[questionIndex]
                      .question,
                  style: theme.primaryTextTheme.displaySmall?.copyWith(
                    color: Colors.blue.shade300,
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          child: BlocBuilder<HelpCubit, HelpState>(
            builder: (context, state) {
              return SizedBox(
                height: state.currentShowIndex != questionIndex ? 0 : null,
                child: SelectionArea(
                  child: Text(
                    ((state.categories ?? [])[pageIndex].questions ??
                            [])[questionIndex]
                        .answer,
                    style: theme.primaryTextTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

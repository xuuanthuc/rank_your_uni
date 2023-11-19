import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/global/style/app_images.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/guideline/widgets/question_item.dart';
import 'bloc/help_cubit.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HelpCubit>(),
      child: const HelpView(),
    );
  }
}

class HelpView extends StatefulWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    context.read<HelpCubit>().getQuestions();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.goNamed(RouteKey.home),
                child:
                    SizedBox(height: 35, child: Image.asset(AppImages.iHomeLogo)),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<HelpCubit, HelpState>(
              builder: (context, state) {
                return (state.categories ?? []).isEmpty
                    ? const SizedBox(width: 1)
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              state.categories?.length ?? 0,
                              (index) => MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    _controller.jumpToPage(index);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Text(
                                        (state.categories ?? [])[index].title ??
                                            '',
                                        style: state.currentCategory == index
                                            ? theme
                                                .primaryTextTheme.displaySmall
                                                ?.copyWith(
                                                    color: Colors.blue.shade300,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700)
                                            : theme
                                                .primaryTextTheme.displaySmall
                                                ?.copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
            Expanded(
              child: BlocBuilder<HelpCubit, HelpState>(
                builder: (context, state) {
                  return (state.categories ?? []).isEmpty
                      ? Container()
                      : PageView.builder(
                          controller: _controller,
                          onPageChanged: (value) {
                            context.read<HelpCubit>().changeCategory(value);
                          },
                          itemBuilder: (context, page) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 30, bottom: 20),
                                    child: Text(
                                      (state.categories ?? [])[page].title ??
                                          '',
                                      style:
                                          theme.primaryTextTheme.displayLarge,
                                    ),
                                  ),
                                  ((state.categories ?? [])[page].questions ??
                                              [])
                                          .isEmpty
                                      ? Container()
                                      : Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return QuestionItem(
                                                state,
                                                page,
                                                questionIndex: index,
                                              );
                                            },
                                            itemCount:
                                                (state.categories ?? [])[page]
                                                    .questions
                                                    ?.length,
                                          ),
                                        ),
                                ],
                              ),
                            );
                          },
                          itemCount: state.categories?.length,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

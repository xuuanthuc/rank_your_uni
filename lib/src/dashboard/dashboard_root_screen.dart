import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import 'bloc/dashboard_cubit.dart';
import 'features/dashboard_universities.dart';

class DashboardPage {
  final IconData icon;
  final String title;
  final Widget child;
  final DashboardPages type;

  DashboardPage({
    required this.icon,
    required this.title,
    required this.child,
    required this.type,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();

  List<DashboardPage> pages = [
    DashboardPage(
      icon: Icons.house,
      title: "Trường học",
      child: const DashboardUniversities(),
      type: DashboardPages.university,
    ),
    DashboardPage(
      icon: Icons.person,
      title: "Tài khoản",
      child: Container(),
      type: DashboardPages.user,
    ),
    DashboardPage(
      icon: Icons.info,
      title: "Báo cáo",
      child: Container(),
      type: DashboardPages.report,
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().onPageChange(pages[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: ResponsiveBuilder.setSize(
              context,
              extraSize: 160,
              mediumSize: 60,
            ),
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              state.page == page.type
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<DashboardCubit>().onPageChange(page);
                            _pageController.jumpToPage(index);
                          },
                          icon: ResponsiveBuilder(
                            mediumView: Icon(
                              page.icon,
                              color: state.page == page.type
                                  ? Colors.white
                                  : AppColors.grey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  page.icon,
                                  color: state.page == page.type
                                      ? Colors.white
                                      : AppColors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  page.title,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: state.page == page.type
                                            ? Colors.white
                                            : AppColors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: pages.length,
                  ),
                );
              },
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppColors.primaryShadow,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  pages.length,
                  (index) => pages[index].child,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

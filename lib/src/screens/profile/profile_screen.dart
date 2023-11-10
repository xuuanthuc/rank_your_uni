import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/appbar/appbar_common.dart';
import 'package:template/src/screens/appbar/widgets/user_button.dart';
import 'package:template/src/screens/profile/bloc/profile_cubit.dart';
import 'package:template/src/screens/profile/edit_account.dart';
import 'package:template/src/screens/profile/edit_profile.dart';
import 'package:template/src/screens/profile/your_rating.dart';
import 'package:template/src/screens/widgets/footer_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class ProfileScreen extends StatelessWidget {
  final QuickMenu menu;

  const ProfileScreen({
    super.key,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProfileCubit>(),
      child: ProfileView(menu: menu),
    );
  }
}

class ProfileView extends StatefulWidget {
  final QuickMenu menu;

  const ProfileView({
    super.key,
    required this.menu,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentIndex;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.menu.index,
    );
    _currentIndex = widget.menu.index;
    context.read<ProfileCubit>().onPageChange(QuickMenu.values[_currentIndex]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const AppbarCommon(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: Public.tabletSize),
              margin: EdgeInsets.symmetric(
                horizontal: ResponsiveBuilder.setHorizontalPadding(context),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          text.hey("Username"),
                          style: theme.primaryTextTheme.displayLarge,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return TabBar(
                        controller: _tabController,
                        labelPadding: EdgeInsets.zero,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        tabs: [
                          TabProfileItem(
                            index: 0,
                            currentIndex: _currentIndex,
                            label: text.profile,
                          ),
                          TabProfileItem(
                            index: 1,
                            currentIndex: _currentIndex,
                            label: text.settingAccount,
                          ),
                          TabProfileItem(
                            index: 2,
                            currentIndex: _currentIndex,
                            label: text.yourRating,
                          ),
                        ],
                        onTap: (index) {
                          if (_currentIndex == index) return;
                          _currentIndex = index;
                          context
                              .read<ProfileCubit>()
                              .onPageChange(QuickMenu.values[index]);
                        },
                      );
                    },
                  ),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state.status == ProfileStatus.loading) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  switch (state.page) {
                    case QuickMenu.profile:
                      return const EditProfile();
                    case QuickMenu.settingAccount:
                      return const EditAccount();
                    case QuickMenu.yourRating:
                      return const YourRatings();
                    default:
                      return Container();
                  }
                }
              },
            ),
            const FooterCommon(),
          ],
        ),
      ),
    );
  }
}

class TabProfileItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String label;

  const TabProfileItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: ResponsiveBuilder.setHorizontalPadding(context),
      ),
      decoration: BoxDecoration(
        color: currentIndex == index ? AppColors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.primaryTextTheme.labelLarge?.copyWith(
          color: currentIndex == index ? Colors.white : AppColors.black,
        ),
      ),
    );
  }
}

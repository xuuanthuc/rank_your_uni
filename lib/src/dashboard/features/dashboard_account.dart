import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/account/dashboard_account_item_cubit.dart';
import 'package:template/src/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/dashboard/features/widget/header_line.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/profile.dart';
import 'package:template/src/screens/widgets/loading.dart';
import '../../screens/widgets/responsive_builder.dart';
import '../bloc/dashboard_cubit.dart';

class DashboardAccounts extends StatelessWidget {
  const DashboardAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardTitle(title: text.contact),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text(
                  text.fulname,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
              const HeaderLine(),
              Expanded(
                flex: 2,
                child: Text(
                  text.phone,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.bodyMedium,
                ),
              ),
              const HeaderLine(),
              Expanded(
                flex: 3,
                child: Text(
                  text.email,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
              const HeaderLine(),
              Expanded(
                flex: 5,
                child: Text(
                  text.body,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.bodyMedium,
                ),
              ),
              const HeaderLine(),
              SizedBox(
                width: ResponsiveBuilder.setSize(
                  context,
                  extraSize: 110,
                  smallSize: 20,
                ),
                child: Text(
                  text.status,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              )
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
                  final account = (state.accounts ?? [])[index];
                  return BlocProvider(
                    create: (context) => getIt.get<DashboardAccountItemCubit>(),
                    child: AccountItem(account: account),
                  );
                },
                itemCount: state.accounts?.length ?? 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class AccountItem extends StatefulWidget {
  final Profile account;

  const AccountItem({
    super.key,
    required this.account,
  });

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardAccountItemCubit>().getAccount(widget.account);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DashboardAccountItemCubit, DashboardAccountItemState>(
      builder: (context, state) {
        if (state.account == null) return Container();
        return InkWell(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const SizedBox(height: 34),
                Expanded(
                  flex: 2,
                  child: Text(
                    state.account!.firstName ?? '',
                    style: theme.primaryTextTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Text(
                    state.account!.firstName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Text(
                    state.account!.email ?? '',
                    style: theme.primaryTextTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/features/widget/contact_detail_dialog.dart';
import 'package:template/src/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/dashboard/features/widget/header_line.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/contact.dart';
import 'package:template/src/screens/widgets/loading.dart';
import '../../screens/widgets/responsive_builder.dart';
import '../bloc/contact/dashboard_contact_item_cubit.dart';
import '../bloc/dashboard_cubit.dart';

class DashboardContact extends StatelessWidget {
  const DashboardContact({super.key});

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
                  final contact = (state.contacts ?? [])[index];
                  return BlocProvider(
                    create: (context) => getIt.get<DashboardContactItemCubit>(),
                    child: ContactItem(contact: contact),
                  );
                },
                itemCount: state.contacts?.length ?? 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ContactItem extends StatefulWidget {
  final Contact contact;

  const ContactItem({
    super.key,
    required this.contact,
  });

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardContactItemCubit>().getContact(widget.contact);
  }

  void _showContactDetailDialog(
    BuildContext context,
    Contact contact,
  ) {
    showDialog<Contact>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<DashboardContactItemCubit>(),
          child: ContactDetailDialog(contact: contact),
        );
      },
    ).then((value) {
      if (value != null) {
        context.read<DashboardContactItemCubit>().getContact(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<DashboardContactItemCubit, DashboardContactItemState>(
      builder: (context, state) {
        if (state.contact == null) return Container();
        return InkWell(
          onTap: () => _showContactDetailDialog(context, state.contact!),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const SizedBox(height: 34),
                Expanded(
                  flex: 2,
                  child: Text(
                    state.contact!.fullName ?? '',
                    style: theme.primaryTextTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Text(
                    state.contact!.phone ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Text(
                    state.contact!.email ?? '',
                    style: theme.primaryTextTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Text(
                    state.contact!.content ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                          color: (state.contact!.resolve ?? false)
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
                            color: (state.contact!.resolve ?? false)
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          (state.contact!.resolve ?? false)
                              ? text.resolved
                              : text.requesting,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

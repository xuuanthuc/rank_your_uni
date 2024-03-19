import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/contact/dashboard_contact_item_cubit.dart';
import 'package:template/src/models/response/contact.dart';
import 'package:template/src/screens/widgets/primary_dialog.dart';
import '../../../../global/utilities/toast.dart';
import '../../../screens/add/add_university.dart';
import '../../../screens/widgets/loading_primary_button.dart';

class ContactDetailDialog extends StatefulWidget {
  final Contact contact;

  const ContactDetailDialog({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetailDialog> createState() => _ContactDetailDialogState();
}

class _ContactDetailDialogState extends State<ContactDetailDialog> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardContactItemCubit>().getContact(widget.contact);
  }

  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return PrimaryDialog(
      child: BlocListener<DashboardContactItemCubit, DashboardContactItemState>(
        listener: (context, state) {
          if (state.status == DashboardContactStatus.success) {
            appToast(context,
                message: AppLocalizations.of(context)!.updateSuccess,
                type: ToastType.success);
            context.pop(state.contact);
          } else if (state.status == DashboardContactStatus.error) {
            appToast(
              context,
              message: AppLocalizations.of(context)!.somethingWrong,
              subMessage: AppLocalizations.of(context)!.tryAgainLater,
            );
          }
        },
        child:
            BlocBuilder<DashboardContactItemCubit, DashboardContactItemState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text.contact,
                  style: theme.primaryTextTheme.displayLarge,
                ),
                const SizedBox(height: 30),
                Text(
                  text.fulname,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  state.contact?.fullName ?? "",
                  style: theme.primaryTextTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  text.phone,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  state.contact?.phone ?? "",
                  style: theme.primaryTextTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  text.email,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  state.contact?.email ?? "",
                  style: theme.primaryTextTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  text.body,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  state.contact?.content ?? "",
                  style: theme.primaryTextTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextAddField(
                  label: text.reply,
                  controller: _replyController,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingPrimaryButton<DashboardContactItemCubit,
                        DashboardContactItemState>(
                      buttonWidth: 270,
                      onTap: () {
                        context
                            .read<DashboardContactItemCubit>()
                            .resolvedContact();
                      },
                      label: text.reply,
                      updateLoading: (state) {
                        return (state).status == DashboardContactStatus.loading;
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

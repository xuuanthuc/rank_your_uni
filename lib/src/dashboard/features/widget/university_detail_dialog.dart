import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/university/dashboard_university_item_cubit.dart';
import 'package:template/src/models/request/update_university_request.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/primary_dialog.dart';
import '../../../../global/utilities/toast.dart';
import '../../../screens/add/add_university.dart';
import '../../../screens/widgets/loading_primary_button.dart';

class UniversityDetailDialog extends StatefulWidget {
  final University university;

  const UniversityDetailDialog({
    super.key,
    required this.university,
  });

  @override
  State<UniversityDetailDialog> createState() => _UniversityDetailDialogState();
}

class _UniversityDetailDialogState extends State<UniversityDetailDialog> {
  @override
  void initState() {
    super.initState();
    context
        .read<DashboardUniversityItemCubit>()
        .getUniversity(widget.university);
    _nameController.text = widget.university.name ?? "";
    _addressController.text = widget.university.address ?? "";
    _websiteController.text = widget.university.website ?? "";
    _abbreviaController.text = widget.university.abbrevia ?? "";
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _websiteController = TextEditingController();

  final TextEditingController _abbreviaController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _websiteController.dispose();
    _abbreviaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return PrimaryDialog(
      child: Form(
        key: _formKey,
        child: BlocListener<DashboardUniversityItemCubit,
            DashboardUniversityItemState>(
          listener: (context, state) {
            if (state.status == DashboardUniversityStatus.success) {
              appToast(
                context,
                message: AppLocalizations.of(context)!.updateSuccess,
                type: ToastType.success
              );
              context.pop(state.university);
            } else if (state.status == DashboardUniversityStatus.error) {
              appToast(
                context,
                message: AppLocalizations.of(context)!.somethingWrong,
                subMessage: AppLocalizations.of(context)!.tryAgainLater,
              );
            }
          },
          child: BlocBuilder<DashboardUniversityItemCubit,
              DashboardUniversityItemState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.updateUniversity,
                    style: theme.primaryTextTheme.displayLarge,
                  ),
                  const SizedBox(height: 30),
                  TextAddField(
                    label: text.nameOfUniversity,
                    controller: _nameController,
                  ),
                  TextAddField(
                    label: text.abbrevia,
                    controller: _abbreviaController,
                  ),
                  TextAddField(
                    label: text.address,
                    controller: _addressController,
                  ),
                  TextAddField(
                    label: text.website,
                    controller: _websiteController,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingPrimaryButton<DashboardUniversityItemCubit,
                          DashboardUniversityItemState>(
                        buttonWidth: 270,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<DashboardUniversityItemCubit>()
                                .updateUniversity(UpdateUniversityRaw(
                                  name: _nameController.text,
                                  address: _addressController.text,
                                  website: _websiteController.text,
                                  code: _abbreviaController.text,
                                ));
                          }
                        },
                        label: text.update,
                        updateLoading: (state) {
                          return (state).status ==
                              DashboardUniversityStatus.loading;
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/professor/dashboard_professor_item_cubit.dart';
import 'package:template/src/models/request/update_professor_request.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/screens/widgets/primary_dialog.dart';
import '../../../../global/utilities/toast.dart';
import '../../../screens/add/add_university.dart';
import '../../../screens/widgets/loading_primary_button.dart';

class ProfessorDetailDialog extends StatefulWidget {
  final Professor professor;

  const ProfessorDetailDialog({
    super.key,
    required this.professor,
  });

  @override
  State<ProfessorDetailDialog> createState() => _ProfessorDetailDialogState();
}

class _ProfessorDetailDialogState extends State<ProfessorDetailDialog> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardProfessorItemCubit>().getProfessors(widget.professor);
    _nameController.text = widget.professor.fullName ?? "";
    // _addressController.text = widget.university.address ?? "";
    // _websiteController.text = widget.university.website ?? "";
    // _abbreviaController.text = widget.university.abbrevia ?? "";
    _isActive = widget.professor.status == 1;
  }

  final _formKey = GlobalKey<FormState>();

  late bool _isActive;

  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return PrimaryDialog(
      child: Form(
        key: _formKey,
        child: BlocListener<DashboardProfessorItemCubit,
            DashboardProfessorItemState>(
          listener: (context, state) {
            if (state.status == DashboardProfessorStatus.success) {
              appToast(context,
                  message: AppLocalizations.of(context)!.updateSuccess,
                  type: ToastType.success);
              context.pop(state.professor);
            } else if (state.status == DashboardProfessorStatus.error) {
              appToast(
                context,
                message: AppLocalizations.of(context)!.somethingWrong,
                subMessage: AppLocalizations.of(context)!.tryAgainLater,
              );
            }
          },
          child: BlocBuilder<DashboardProfessorItemCubit,
              DashboardProfessorItemState>(
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
                    label: text.fullName,
                    controller: _nameController,
                  ),
                  Row(
                    children: [
                      Switch(
                        // This bool value toggles the switch.
                        value: _isActive,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            _isActive = !_isActive;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      Text(
                        text.universityActived,
                        style: theme.primaryTextTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingPrimaryButton<DashboardProfessorItemCubit,
                          DashboardProfessorItemState>(
                        buttonWidth: 270,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<DashboardProfessorItemCubit>()
                                .updateProfessor(UpdateProfessorRaw(
                                  widget.professor.id,
                                  fullName: _nameController.text,
                                  majorId: widget.professor.major?.id,
                                  universityId: widget.professor.university?.id,
                                  status: _isActive ? 1 : 0,
                                ));
                          }
                        },
                        label: text.update,
                        updateLoading: (state) {
                          return (state).status ==
                              DashboardProfessorStatus.loading;
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

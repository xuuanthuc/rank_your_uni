import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/guideline/bloc/help_cubit.dart';
import 'package:template/src/screens/widgets/loading_primary_button.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../widgets/base_dialog.dart';

class ContactUsDialog extends StatelessWidget {
  const ContactUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HelpCubit>(),
      child: const ContactUsView(),
    );
  }
}

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BaseDialog(
      child: Form(
        key: _formKey,
        child: BlocListener<HelpCubit, HelpState>(
          listener: (context, state) {
            if (state.status == HelpStatus.success) {
              appToast(
                context,
                type: ToastType.success,
                message: AppLocalizations.of(context)!.somethingWrong,
                subMessage: AppLocalizations.of(context)!.tryAgainLater,
              );
            } else if (state.status == HelpStatus.error) {
              appToast(
                context,
                message: AppLocalizations.of(context)!.somethingWrong,
                subMessage: AppLocalizations.of(context)!.tryAgainLater,
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text.addAUniversity,
                style: theme.primaryTextTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              Text(
                text.addAUniversityWarning,
                style: theme.primaryTextTheme.bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 30),
              TextAddField(
                label: text.enterFullName,
                controller: _fullNameController,
              ),
              TextAddField(
                label: text.email,
                controller: _emailController,
              ),
              TextAddField(
                label: text.phone,
                controller: _phoneController,
              ),
              TextAddField(
                label: text.contact,
                controller: _messageController,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingPrimaryButton<HelpCubit, HelpState>(
                    buttonWidth: 270,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    label: text.addUniversity,
                    updateLoading: (state) {
                      return (state).status == HelpStatus.loading;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextAddField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final Function? onTap;
  final TextEditingController controller;

  const TextAddField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.primaryTextTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        TextFormField(
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          validator: TextFieldValidator.notEmptyValidator,
          controller: controller,
          readOnly: readOnly,
          onTap: () {
            if (onTap == null) return;
            onTap!();
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            hoverColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            isDense: true,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/request/contact.dart';
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
              if (context.mounted) {
                appToast(
                  context,
                  type: ToastType.success,
                  message: AppLocalizations.of(context)!.sendSuccess,
                  subMessage: AppLocalizations.of(context)!.weWillResponseSoon,
                );
                context.pop();
              }
            } else if (state.status == HelpStatus.error) {
              if (context.mounted) {
                appToast(
                  context,
                  message: AppLocalizations.of(context)!.somethingWrong,
                  subMessage: AppLocalizations.of(context)!.tryAgainLater,
                );
                context.pop();
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text.contactUs,
                style: theme.primaryTextTheme.displayLarge,
              ),
              const SizedBox(height: 30),
              ContactField(
                label: text.enterFullName,
                controller: _fullNameController,
              ),
              ContactField(
                label: text.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              ContactField(
                label: text.phone,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              ContactField(
                label: text.message,
                maxLines: 5,
                controller: _messageController,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingPrimaryButton<HelpCubit, HelpState>(
                    buttonWidth: 270,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<HelpCubit>().sentMessageContact(
                              ContactRaw(
                                fullName: _fullNameController.text.trim(),
                                email: _emailController.text.trim(),
                                phone: _phoneController.text.trim(),
                                message: _messageController.text.trim(),
                              ),
                            );
                      }
                    },
                    label: text.send,
                    updateLoading: (state) {
                      return state.status == HelpStatus.loading;
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

class ContactField extends StatelessWidget {
  final String label;
  final int maxLines;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const ContactField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: theme.primaryTextTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        validator: TextFieldValidator.notEmptyValidator,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: label,
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
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          isDense: true,
        ),
      ),
    );
  }
}

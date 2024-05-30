import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/primary_dialog.dart';
import '../../../../global/validators/validators.dart';
import '../../../screens/widgets/primary_button.dart';

class AddTagDialog extends StatefulWidget {
  const AddTagDialog({super.key});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {

  final TextEditingController _controller = TextEditingController()
;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return PrimaryDialog(
      maxWidth: Public.mobileSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text.addTag,
            style: theme.primaryTextTheme.displaySmall,
          ),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text.tagName,
                style: theme.primaryTextTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              TextFormField(
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                validator: TextFieldValidator.notEmptyValidator,
                controller: _controller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.grey),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.grey),
                  ),
                  hoverColor: Colors.transparent,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
          const SizedBox(height: 25),
          PrimaryButton(
            onTap: () {
              context.pop(_controller.text);
            },
            title: text.addTag,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          ),
        ],
      ),
    );
  }
}

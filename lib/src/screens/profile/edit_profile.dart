import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/profile/widgets/edit_button.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.tabletSize),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveBuilder.setHorizontalPadding(context),
          ),
          child: Column(
            children: [
              SizedBox(height: ResponsiveBuilder.setHorizontalPadding(context)),
              EditButton(onTap: () {}),
              const SizedBox(height: 25),
              SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelField(text.lastName),
                        LabelField(text.firstName),
                        LabelField(text.universityName),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldData(text.enterLastName),
                          TextFieldData(text.enterFirstName),
                          TextFieldData(text.whatIsYourUniversity),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(onTap: (){}, title: text.updateProfile)
                ],
              ),
              const SizedBox(height: 500),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelField extends StatelessWidget {
  final String label;

  const LabelField(
    this.label, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(label, style: theme.primaryTextTheme.labelLarge),
    );
  }
}

class TextFieldData extends StatelessWidget {
  final String hint;

  const TextFieldData(this.hint, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      style: theme.primaryTextTheme.labelLarge,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: theme.primaryTextTheme.bodyLarge
              ?.copyWith(color: AppColors.textGrey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: AppColors.grey),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
    );
  }
}

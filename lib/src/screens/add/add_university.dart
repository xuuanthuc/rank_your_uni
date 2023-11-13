import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import '../../../global/style/styles.dart';
import '../widgets/button_common.dart';
import '../widgets/responsive_builder.dart';

class AddUniversity extends StatelessWidget {
  const AddUniversity({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(
              ResponsiveBuilder.setHorizontalPadding(context),
            ),
            constraints: const BoxConstraints(
              maxWidth: Public.laptopSize,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: Public.mobileSize,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      label: text.nameOfUniversity,
                    ),
                    TextAddField(
                      label: text.stateOrWard,
                    ),
                    TextAddField(
                      label: text.cityOrProvince,
                    ),
                    TextAddField(
                      label: text.website,
                    ),
                    TextAddField(
                      label: text.yourEmail,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.all(theme.primaryColor),
                            value: true,
                            onChanged: (bool? value) {},
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            text.agreeTermsOfUse,
                            style: theme.primaryTextTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          onTap: () => {},
                          title: text.addUniversity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextAddField extends StatelessWidget {
  final String label;

  const TextAddField({super.key, required this.label});

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
        TextField(
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          cursorHeight: 18,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
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

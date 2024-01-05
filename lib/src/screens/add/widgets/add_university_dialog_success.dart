import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/models/request/add_university_request.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../../global/style/app_images.dart';
import '../../../../global/utilities/public.dart';
import '../../widgets/primary_button.dart';

class AddUniversityDialogSuccess extends StatefulWidget {
  final AddUniversityRaw university;

  const AddUniversityDialogSuccess({super.key, required this.university});

  @override
  State<AddUniversityDialogSuccess> createState() =>
      _AddUniversityDialogSuccessState();
}

class _AddUniversityDialogSuccessState
    extends State<AddUniversityDialogSuccess> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: Public.tabletSize),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveBuilder.setHorizontalPadding(context),
          vertical: 10
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SvgPicture.asset(AppImages.iSuccessBg),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.iHandHeart),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      text.thankForAddUniversity(widget.university.name ?? ''),
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    text.yourUniversityUnderReview,
                    style: theme.primaryTextTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    child: PrimaryButton(
                      onTap: () {
                        context.pop();
                      },
                      title: text.close,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

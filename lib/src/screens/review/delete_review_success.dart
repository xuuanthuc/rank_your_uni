import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import '../../../global/routes/route_keys.dart';
import '../widgets/responsive_builder.dart';

class ReviewDeletedSuccessScreen extends StatefulWidget {
  final University university;

  const ReviewDeletedSuccessScreen({
    super.key,
    required this.university,
  });

  @override
  State<ReviewDeletedSuccessScreen> createState() =>
      _ReviewDeletedSuccessScreenState();
}

class _ReviewDeletedSuccessScreenState
    extends State<ReviewDeletedSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(maxContentWidth: Public.tabletSize, children: [
      if (widget.university.name != null)
        Stack(
          children: [
            SvgPicture.asset(AppImages.iSuccessBg),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  SvgPicture.asset(AppImages.iHandHeart),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      text.deleteSuccess,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    text.deleteSuccessDescription,
                    style: theme.primaryTextTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    child: PrimaryButton(
                      onTap: () {
                        context.goNamed(
                          RouteKey.university,
                          pathParameters: {"id": "${widget.university.id}"},
                          extra: widget.university,
                        );
                      },
                      title: text.seeReview,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
    ]);
  }
}

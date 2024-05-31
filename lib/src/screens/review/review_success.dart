import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/routes/route_keys.dart';

class ReviewUniversitySuccessScreen extends StatefulWidget {
  final University university;

  const ReviewUniversitySuccessScreen({
    super.key,
    required this.university,
  });

  @override
  State<ReviewUniversitySuccessScreen> createState() =>
      _ReviewUniversitySuccessScreenState();
}

class _ReviewUniversitySuccessScreenState
    extends State<ReviewUniversitySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      maxContentWidth: Public.tabletSize,
      children: [
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
                        text.thanksForReviewUniversity(
                            widget.university.name ?? ''),
                        style: theme.textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Text(
                    //   text.yourReviewAreSubmitting,
                    //   style: theme.primaryTextTheme.bodyMedium,
                    //   textAlign: TextAlign.center,
                    // ),
                    MarkdownBody(
                      data:
                          'Rank Your UNi sẽ ngày càng hoàn thiện hơn với những đánh giá của bạn 💚. Chúng mình hi vọng bạn sẽ tiếp tục đưa ra các đánh giá liên quan tới giảng đường nhằm góp phần nâng cao chất lượng giáo dục. Xin lưu ý, các đánh giá vi phạm [hướng dẫn sử dụng trang](https://rankyouruni.com/guidelines) sẽ có thể bị ẩn bởi chúng mình nhằm mục đích đảm bảo các nguyên tắc trang 👀. ',
                      selectable: true,
                      onTapLink: (t, u, c) async {
                        if (u != null) {
                          if (!await launchUrl(Uri.parse(u))) {
                            throw Exception('Could not launch $u');
                          }
                        }
                      },
                      styleSheet: MarkdownStyleSheet(
                        a: theme.primaryTextTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.info,
                        ),
                        p: theme.primaryTextTheme.bodyMedium,
                      ),
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
      ],
    );
  }
}

class ReviewProfessorSuccessScreen extends StatefulWidget {
  final Professor professor;

  const ReviewProfessorSuccessScreen({
    super.key,
    required this.professor,
  });

  @override
  State<ReviewProfessorSuccessScreen> createState() =>
      _ReviewProfessorSuccessScreenState();
}

class _ReviewProfessorSuccessScreenState
    extends State<ReviewProfessorSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      maxContentWidth: Public.tabletSize,
      children: [
        if (widget.professor.fullName != null)
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
                        text.thanksForReviewProfessor(
                          widget.professor.fullName ?? '',
                        ),
                        style: theme.textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Text(
                    //   text.yourReviewAreSubmitting,
                    //   style: theme.primaryTextTheme.bodyMedium,
                    //   textAlign: TextAlign.center,
                    // ),
                    MarkdownBody(
                      data:
                          'Rank Your UNi sẽ ngày càng hoàn thiện hơn với những đánh giá của bạn 💚. Chúng mình hi vọng bạn sẽ tiếp tục đưa ra các đánh giá liên quan tới giảng đường nhằm góp phần nâng cao chất lượng giáo dục. Xin lưu ý, các đánh giá vi phạm [hướng dẫn sử dụng trang](https://rankyouruni.com/guidelines) sẽ có thể bị ẩn bởi chúng mình nhằm mục đích đảm bảo các nguyên tắc trang 👀. ',
                      selectable: true,
                      onTapLink: (t, u, c) async {
                        if (u != null) {
                          if (!await launchUrl(Uri.parse(u))) {
                            throw Exception('Could not launch $u');
                          }
                        }
                      },
                      styleSheet: MarkdownStyleSheet(
                        a: theme.primaryTextTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.info,
                        ),
                        p: theme.primaryTextTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 200,
                      child: PrimaryButton(
                        onTap: () {
                          context.goNamed(
                            RouteKey.professor,
                            pathParameters: {"id": "${widget.professor.id}"},
                            extra: widget.professor,
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
      ],
    );
  }
}

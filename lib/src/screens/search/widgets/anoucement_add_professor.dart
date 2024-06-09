import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global/style/styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_dialog.dart';

class AnnoucementAddProfessor extends StatelessWidget {
  const AnnoucementAddProfessor({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return PrimaryDialog(
      maxWidth: Public.mobileSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.iHandHeart),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: MarkdownBody(
              data:
                  'Danh sách giảng viên vẫn đang được cập nhật. Nếu bạn không tìm thấy giảng viên của mình thì hãy bấm vào [thêm giảng viên](https://rankyouruni.com/add/lecturer). Bằng cách thêm giảng viên, bạn đang giúp chúng mình xây dựng một cộng đồng RYU ngày một phát triển và đầy đủ hơn.',
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
          ),
          SizedBox(
            width: 120,
            child: PrimaryButton(
              onTap: () {
                context.pop();
              },
              title: text.close,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

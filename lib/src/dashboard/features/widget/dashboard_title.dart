import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../bloc/dashboard_cubit.dart';

class DashboardTitle extends StatelessWidget {
  final String title;

  const DashboardTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: AutoSizeText(
              title,
              minFontSize: 12,
              maxLines: 1,
              style: Theme.of(context).primaryTextTheme.displayLarge,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              context.read<DashboardCubit>().onRefresh();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary)),
            icon: ResponsiveBuilder(
              smallView: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.refresh,
                    style:
                        Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import 'package:template/global/style/styles.dart';
import '../../../global/routes/route_keys.dart';

class FooterCommon extends StatefulWidget {
  const FooterCommon({super.key});

  @override
  State<FooterCommon> createState() => _FooterCommonState();
}

class _FooterCommonState extends State<FooterCommon> {
  bool _isFull = false;

  void _onToggleFooter() {
    setState(() {
      _isFull = !_isFull;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Container(
      color: theme.primaryColor,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ResponsiveBuilder(
        smallView: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ArrowButton(
                onTap: () => _onToggleFooter(),
                isFull: _isFull,
              ),
              const SizedBox(height: 8),
              const FooterLogo(alignment: Alignment.center),
              const SizedBox(height: 12),
              _isFull
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text.side,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FooterOptionButton(
                              label: text.help,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FooterOptionButton(
                              label: text.sideGuidelines,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              if (_isFull) const SizedBox(height: 30),
              const CopyRightText(),
              const SizedBox(height: 20),
            ],
          ),
        ),
        child: Center(
          child: AnimatedSize(
            alignment: Alignment.bottomCenter,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            child: Container(
              constraints: const BoxConstraints(maxWidth: Public.desktopSize),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: _isFull
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      text.side,
                                      style:
                                          theme.textTheme.labelLarge?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FooterOptionButton(
                                      label: text.help,
                                      onTap: () {},
                                    ),
                                    const SizedBox(height: 8),
                                    FooterOptionButton(
                                      label: text.sideGuidelines,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    FooterLogo(),
                                    SizedBox(height: 12),
                                    CopyRightText(),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CopyRightText(),
                                FooterLogo(),
                              ],
                            ),
                          ),
                  ),
                  ArrowButton(
                    onTap: () => _onToggleFooter(),
                    isFull: _isFull,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FooterOptionButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const FooterOptionButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () => onTap(),
      hasBorder: false,
      title: label,
      isOutline: true,
      titleTextStyleColor: Colors.white,
      padding: EdgeInsets.zero,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
  }
}

class ArrowButton extends StatelessWidget {
  final Function onTap;
  final bool isFull;

  const ArrowButton({
    super.key,
    required this.onTap,
    required this.isFull,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: IconButton(
          onPressed: () => onTap(),
          icon: RotatedBox(
            quarterTurns: isFull ? 1 : 3,
            child: const Icon(
              Icons.double_arrow_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CopyRightText extends StatelessWidget {
  const CopyRightText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Text(
      text.copyRight,
      style: theme.primaryTextTheme.bodyMedium?.copyWith(
        color: Colors.white,
      ),
    );
  }
}

class FooterLogo extends StatelessWidget {
  const FooterLogo({
    super.key,
    this.alignment = Alignment.centerRight,
  });

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.go(RouteKey.home);
          },
          child: SvgPicture.asset(
            AppImages.iLogoWhite,
            alignment: alignment,
          ),
        ),
      ),
    );
  }
}

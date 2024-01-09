import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final Function onTap;
  final String title;
  final bool isOutline;
  final bool hasBorder;
  final TextStyle? titleTextStyle;
  final Color? titleTextStyleColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Widget? child;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Alignment alignment;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isOutline = false,
    this.hasBorder = true,
    this.alignment = Alignment.center,
    this.titleTextStyle,
    this.titleTextStyleColor,
    this.backgroundColor,
    this.borderColor,
    this.height,
    this.padding,
    this.child,
    this.fontWeight,
    this.fontSize,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isUnderLine = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MouseRegion(
      onHover: (details) {
        setState(() {
          _isUnderLine = true;
        });
      },
      onExit: (details) {
        setState(() {
          _isUnderLine = false;
        });
      },
      child: TextButton(
        onPressed: () => widget.onTap(),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          overlayColor: MaterialStateProperty.all(
            widget.hasBorder ? theme.colorScheme.surface : Colors.transparent,
          ),
          backgroundColor: MaterialStateProperty.all(
            widget.isOutline
                ? Colors.transparent
                : widget.backgroundColor ?? theme.primaryColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              side: BorderSide(
                width: 2,
                color: widget.hasBorder
                    ? widget.borderColor ?? theme.primaryColor
                    : Colors.transparent,
              ),
            ),
          ),
        ),
        child: Container(
          height: widget.height,
          padding: widget.padding ??
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
          child: Align(
            alignment: widget.alignment,
            child: widget.child ??
                Text(
                  widget.title,
                  style: widget.titleTextStyle ??
                      theme.primaryTextTheme.labelLarge?.copyWith(
                        color: widget.titleTextStyleColor ?? Colors.white,
                        decoration: widget.hasBorder
                            ? null
                            : _isUnderLine
                                ? TextDecoration.underline
                                : null,
                        decorationColor:
                            widget.titleTextStyleColor ?? Colors.white,
                        decorationThickness: 2,
                        fontWeight: widget.fontWeight,
                        fontSize: widget.fontSize,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}

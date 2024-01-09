import 'package:flutter/material.dart';
import 'package:template/global/utilities/public.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget? tinyView;
  final Widget? smallView;
  final Widget? mediumView;
  final Widget? largeView;
  final Widget child;

  const ResponsiveBuilder({
    super.key,
    this.tinyView,
    this.smallView,
    this.mediumView,
    this.largeView,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        if (MediaQuery.sizeOf(context).width < Public.mobileSize) {
          return tinyView ?? smallView ?? mediumView ?? largeView ?? child;
        } else if (MediaQuery.sizeOf(context).width > Public.mobileSize &&
            MediaQuery.sizeOf(context).width < Public.tabletSize) {
          return smallView ?? mediumView ?? largeView ?? child;
        } else if (MediaQuery.sizeOf(context).width > Public.tabletSize &&
            MediaQuery.sizeOf(context).width < Public.laptopSize) {
          return mediumView ?? largeView ?? child;
        } else if (MediaQuery.sizeOf(context).width > Public.laptopSize &&
            MediaQuery.sizeOf(context).width < Public.desktopSize) {
          return largeView ?? child;
        } else if (MediaQuery.sizeOf(context).width > Public.desktopSize) {
          return child;
        }
        return child;
      },
    );
  }

  static double setSize(BuildContext context,
      {double? tinySize,
      double? smallSize,
      double? mediumSize,
      double? largeSize,
      required double extraSize}) {
    if (MediaQuery.sizeOf(context).width < Public.mobileSize) {
      return tinySize ?? smallSize ?? mediumSize ?? largeSize ?? extraSize;
    } else if (MediaQuery.sizeOf(context).width > Public.mobileSize &&
        MediaQuery.sizeOf(context).width < Public.tabletSize) {
      return smallSize ?? mediumSize ?? largeSize ?? extraSize;
    } else if (MediaQuery.sizeOf(context).width > Public.tabletSize &&
        MediaQuery.sizeOf(context).width < Public.laptopSize) {
      return mediumSize ?? largeSize ?? extraSize;
    } else if (MediaQuery.sizeOf(context).width > Public.laptopSize &&
        MediaQuery.sizeOf(context).width < Public.desktopSize) {
      return largeSize ?? extraSize;
    } else if (MediaQuery.sizeOf(context).width > Public.desktopSize) {
      return  extraSize;
    }
    return extraSize;
  }

  static double setHorizontalPadding(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < Public.mobileSize) {
      return 20;
    } else if (MediaQuery.sizeOf(context).width > Public.mobileSize &&
        MediaQuery.sizeOf(context).width < Public.tabletSize) {
      return 35;
    } else if (MediaQuery.sizeOf(context).width > Public.tabletSize &&
        MediaQuery.sizeOf(context).width < Public.laptopSize) {
      return 40;
    } else if (MediaQuery.sizeOf(context).width > Public.laptopSize &&
        MediaQuery.sizeOf(context).width < Public.desktopSize) {
      return 50;
    } else if (MediaQuery.sizeOf(context).width > Public.desktopSize) {
      return 60;
    }
    return 60;
  }
}

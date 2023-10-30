import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../../global/style/app_images.dart';
import '../../../../global/utilities/public.dart';

class HomeDescription extends StatefulWidget {
  const HomeDescription({super.key});

  @override
  State<HomeDescription> createState() => _HomeDescriptionState();
}

class _HomeDescriptionState extends State<HomeDescription> {
  Size? myChildSize;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: myChildSize?.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: ResponsiveBuilder(
              mediumView: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  child: Image.asset(AppImages.iHomeBody1)),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  child: Image.asset(AppImages.iHomeBody1)),
            ),
          ),
          Positioned(
            left: 0,
            child: ResponsiveBuilder(
              mediumView: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: Image.asset(AppImages.iHomeBody2)),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Image.asset(AppImages.iHomeBody2)),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ResponsiveBuilder(
              mediumView: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Image.asset(AppImages.iHomeBody3)),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: Image.asset(AppImages.iHomeBody3)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: MeasureSize(
              onChange: (size){
                setState(() {
                  myChildSize = size;
                  print(size);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 45),
                    Text(
                      text.joinWithUs,
                      style: theme.primaryTextTheme.displayLarge,
                    ),
                    const SizedBox(height: 35),
                    Text(
                      text.shareForEveryone,
                      style: theme.primaryTextTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    ResponsiveBuilder(
                      mediumView: Column(
                        children: [
                          HomeBodyItemDescription(
                            text: text.managerAndEditYourRate,
                            image: AppImages.iHomeManager,
                          ),
                          HomeBodyItemDescription(
                            text: text.yourRateAlwaysAnonymous,
                            image: AppImages.iHomePrivate,
                          ),
                          HomeBodyItemDescription(
                            text: text.likeOrDislike,
                            image: AppImages.iHomeLike,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HomeBodyItemDescription(
                            text: text.managerAndEditYourRate,
                            image: AppImages.iHomeManager,
                          ),
                          HomeBodyItemDescription(
                            text: text.yourRateAlwaysAnonymous,
                            image: AppImages.iHomePrivate,
                          ),
                          HomeBodyItemDescription(
                            text: text.likeOrDislike,
                            image: AppImages.iHomeLike,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 75),
                    SizedBox(
                      width: 300,
                      child: AppButton(
                        onTap: () {},
                        title: text.signUpNow,
                        titleTextStyle: theme.textTheme.labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeBodyItemDescription extends StatelessWidget {
  final String text;
  final String image;

  const HomeBodyItemDescription({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          SizedBox(
            width: Public.desktopSize * 0.2,
            child: Image.asset(image),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: theme.primaryTextTheme.displayMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}


typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}

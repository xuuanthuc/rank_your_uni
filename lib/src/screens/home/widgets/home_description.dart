import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import 'package:template/global/style/styles.dart';

class HomeDescription extends StatefulWidget {
  const HomeDescription({super.key});

  @override
  State<HomeDescription> createState() => _HomeDescriptionState();
}

class _HomeDescriptionState extends State<HomeDescription> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: ResponsiveBuilder(
              tinyView: Container(
                  margin: const EdgeInsets.only(top: 300),
                  width: MediaQuery.sizeOf(context).width * 1.5,
                  child: Image.asset(AppImages.iHomeBody2)),
              mediumView: Container(
                margin: const EdgeInsets.only(top: 300),
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
                  width: MediaQuery.sizeOf(context).width * 1.5,
                  child: Image.asset(AppImages.iHomeBody3)),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Image.asset(AppImages.iHomeBody3)),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ResponsiveBuilder(
              mediumView: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.75,
                  child: Image.asset(AppImages.iHomeBody1)),
              largeView: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Image.asset(AppImages.iHomeBody1)),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: Image.asset(AppImages.iHomeBody1)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
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
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
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

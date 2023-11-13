import 'package:flutter/material.dart';
import '../appbar/appbar_common.dart';
import 'footer_common.dart';

class AppScaffold extends StatelessWidget {
  final List<Widget> children;
  final String? keyword;

  const AppScaffold({super.key, required this.children, this.keyword});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppbarCommon(keyword: keyword),
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverList(

              delegate: SliverChildListDelegate(
                children,
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FooterCommon(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

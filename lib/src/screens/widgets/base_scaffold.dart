import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/utilities/static_variable.dart';
import '../../global_bloc/authentication/authentication_bloc.dart';
import '../appbar/appbar_common.dart';
import 'footer_common.dart';

class AppScaffold extends StatefulWidget {
  final List<Widget> children;
  final String? keyword;

  const AppScaffold({super.key, required this.children, this.keyword});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {

  @override
  void initState() {
    super.initState();
    if (StaticVariable.tokenIsNotChecked) {
      context.read<AuthenticationBloc>().add(OnCheckToken());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppbarCommon(keyword: widget.keyword),
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverList(

              delegate: SliverChildListDelegate(
                widget.children,
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

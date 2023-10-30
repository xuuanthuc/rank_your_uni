import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/appbar_common.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarCommon(),
      body: Container(),
    );
  }
}

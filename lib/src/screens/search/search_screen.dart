import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/appbar_common.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(
        onSearch: () {},
      ),
    );
  }
}

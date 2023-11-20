import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

class BlankScreen extends StatefulWidget {
  const BlankScreen({super.key});

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(children: []);
  }
}

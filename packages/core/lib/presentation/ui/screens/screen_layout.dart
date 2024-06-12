import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final AppBar? appBar;
  // SliverAppBar? sliverAppBar;
  final Widget child;

  const ScreenLayout({super.key, this.appBar, required this.child});
  // List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: child,
    );
  }
}

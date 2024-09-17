import 'dart:math';

import 'package:fluffychat/config/global_config.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  static const double _width = 400;
  const EmptyPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = min(MediaQuery.of(context).size.width, EmptyPage._width) / 2;
    return Scaffold(
      // Add invisible appbar to make status bar on Android tablets bright.
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/info-logo.png',
          width: width,
          height: width,
          filterQuality: FilterQuality.medium,
          package: GlobalConfig.packageName,
        ),
      ),
    );
  }
}

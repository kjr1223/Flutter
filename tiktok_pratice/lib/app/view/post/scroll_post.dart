import 'package:flutter/material.dart';
import 'package:tiktok_pratice/app/view/post/widgets/bottom_bar.dart';
import 'package:tiktok_pratice/app/view/post/widgets/curentScreen.dart';

Widget scrollPost() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(child: currentScreen()),
      BottomBar(),
    ],
  );
}

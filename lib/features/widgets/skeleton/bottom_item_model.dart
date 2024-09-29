import 'package:flutter/material.dart';

class BottomItemModel {
  final String title;
  final IconData icon;
  final String path;
  double offsetX = 0;
  double offsetY = 0;

  BottomItemModel(
      {required this.title,
      required this.path,
      required this.icon,
      this.offsetX = 0,
      this.offsetY = 0});
}

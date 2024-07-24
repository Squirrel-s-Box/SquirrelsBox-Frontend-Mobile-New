import 'dart:math' as math;

import 'package:flutter/material.dart';

class Responsive {
  late double _width, _height, _diagonal, _pixelRatio;
  late double _textScaler;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt((_width * _width) + (_height * _height));
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _textScaler = MediaQuery.textScalerOf(context).scale(1);
  }

  double get width => _width;

  double get height => _height;

  double get diagonal => _diagonal;

  double wp(double percent) => _width * (percent / 100);

  double hp(double percent) => _height * (percent / 100);

  double dg(double percent) => _diagonal * (percent / 100);

  double sp(double fontSize) => fontSize * _textScaler;

  double dp(double percent) {
    double diagonalInDp = _diagonal / (_pixelRatio * _pixelRatio);
    return math.sqrt(diagonalInDp) * (percent / 100);
  }
}

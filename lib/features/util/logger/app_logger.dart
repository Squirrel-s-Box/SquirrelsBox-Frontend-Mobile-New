import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void log(dynamic message) {
    if (!kReleaseMode) {
      _logger.d(message);
    }
  }

  static void error(dynamic message) {
    if (!kReleaseMode) {
      _logger.e(message);
    }
  }

  static void info(dynamic message) {
    if (!kReleaseMode) {
      _logger.i(message);
    }
  }
}
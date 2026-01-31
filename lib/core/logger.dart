import "package:logger/logger.dart";

abstract class Log {
  static final _logger = Logger(printer: PrettyPrinter(printEmojis: false));

  static bool _enabled = true;

  static void enable() => _enabled = true;

  static void disable() => _enabled = false;

  static bool get isEnabled => _enabled;

  static void trace(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) _logger.t(message);
  }

  static void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) _logger.d(message);
  }

  static void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) _logger.i(message);
  }

  static void warning(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) _logger.w(message);
  }

  static void error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) _logger.e(message);
  }

  static void fatal(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) _logger.f(message);
  }
}

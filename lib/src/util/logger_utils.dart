import 'dart:developer';

class Logger {
  static debug(dynamic value, {String tag = 'Logger'}) {
    log("$tag : ${value.toString()}");
  }
}

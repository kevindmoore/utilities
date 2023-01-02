
import 'dart:io';

import 'package:flutter/foundation.dart';

bool isWeb() {
  return kIsWeb;
}

bool isDesktop() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

bool isMobile() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isIOS || Platform.isAndroid;
}

bool isMac() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isMacOS;
}

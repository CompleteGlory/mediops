 import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Size getDesignSize() {
    if (kIsWeb) {
      return const Size(1440, 900);
    }

    if (Platform.isAndroid || Platform.isIOS) {
      return const Size(375, 812);
    }

    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return const Size(1440, 900);
    }

    return const Size(375, 812);
  }
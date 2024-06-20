import 'dart:io';

import 'package:flutter/material.dart';

class BottomState {
  static double heightInsets(BuildContext context) {
    double insets = MediaQuery.of(context).viewPadding.bottom;
    double extraHeight = insets > 0 ? 10 : 0;
    return Platform.isIOS ? extraHeight : insets;
  }
}

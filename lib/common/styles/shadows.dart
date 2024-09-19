import 'package:flutter/material.dart';

import '../../utils/contsants/colors.dart';
class TShadowStyle{
  static final verticalProductShadow = BoxShadow(
    color: TColors.darkgrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0,2)
  );

  static final HorizontalProductShadow = BoxShadow(
      color: TColors.darkgrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0,2)
  );
}
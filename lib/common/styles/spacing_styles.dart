import 'package:flutter/material.dart';

import '../../utils/contsants/sizes.dart';
 class TSpacingStyle{
   static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
       top: TSizes.appBarheight,
       left : TSizes.defaultSpace,
       bottom: TSizes.defaultSpace,
       right: TSizes.defaultSpace
   );
 }

import 'package:flutter/material.dart';

import '../../../../../utils/contsants/image_strings.dart';
import '../../../../../utils/contsants/sizes.dart';
import '../../../../../utils/contsants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image(
        //   height: 150,
        //   image: AssetImage(
        //       dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        // ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.loginSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
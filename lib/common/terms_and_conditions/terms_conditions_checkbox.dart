
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../utils/contsants/colors.dart';
import '../../../utils/contsants/sizes.dart';
import '../../../utils/contsants/text_strings.dart';
import '../../repositries/authentication/controller/signup/signup_controller.dart';
import '../../utils/helpers/helper_functions.dart';
class TTermsAndConditionsCheckBox extends StatelessWidget {
  const TTermsAndConditionsCheckBox({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final controlller = SignupController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controlller.privacyPolicy.value,
                onChanged: (value) => controlller.privacyPolicy.value =
                    !controlller.privacyPolicy.value))),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${TTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${TTexts.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.primary,
                decoration: TextDecoration.underline,
                decorationColor:
                dark ? TColors.white : TColors.primary,
              )),
          TextSpan(
              text: '${TTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: TTexts.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.primary,
                decoration: TextDecoration.underline,
                decorationColor:
                dark ? TColors.white : TColors.primary,
              )),
        ]))
      ],
    );
  }
}

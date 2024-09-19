
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/contsants/colors.dart';
import '../../utils/contsants/sizes.dart';
class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.actiontext,
      this.showAction = false,
      this.onActionPressed});

  final String text;
  final String animation;
  final String? actiontext;
  final bool showAction;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: TSizes.defaultSpace,
        ),
        showAction
            ? SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                  style:
                      OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                  child: Text(
                    actiontext!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: TColors.light),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    ));
  }
}

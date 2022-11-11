import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mealdash_app/utils/constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          margin: const EdgeInsets.all(defaultPadding),
          child: DefaultTextStyle(
            style: GoogleFonts.satisfy(
              fontSize: 60.0,
              fontWeight: FontWeight.w200,
              color: Theme.of(context).primaryColor,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                    'Create a profile to build and sell Meal Plans...'),
              ],
              isRepeatingAnimation: false,
              displayFullTextOnTap: true,
            ),
          ),
        ),
        // const SizedBox(height: defaultPadding),
      ],
    );
  }
}

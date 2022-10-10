import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart' as constants;

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: constants.defaultPadding * 2),
        Row(
          children: [
            // const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/logo_transparent.png",
              ),
            ),
            // const Spacer(),
          ],
        ),
        const SizedBox(height: constants.defaultPadding * 2),
      ],
    );
  }
}

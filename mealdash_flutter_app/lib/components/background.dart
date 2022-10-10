import 'package:flutter/material.dart';
import '../utils/constants.dart' as constants;

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Hero(
                tag: "topImage",
                child: Image.asset(
                  constants.backgroundTopLeftImage,
                  width: 120,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Hero(
                  tag: "bottomImage",
                  child: Image.asset(constants.backgroundBottomRightImage,
                      width: 120)),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

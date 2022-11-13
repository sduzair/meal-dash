import 'package:flutter/material.dart';

class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: child,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
}

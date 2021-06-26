import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {this.child,
      this.color,
      this.borderRadius: 2.0,
      this.onPressed,
      this.height: 50,
      this.isLoading: false})
      : assert(borderRadius != null);

  final bool isLoading;
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: isLoading
            ? ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                ),
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return color;
                  }
                  return color;
                }),
              )
            : ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),
              ),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

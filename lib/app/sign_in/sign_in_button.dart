import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    @required String text,
    bool isLoading,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
          isLoading: isLoading,
          height: 50,
        );
}

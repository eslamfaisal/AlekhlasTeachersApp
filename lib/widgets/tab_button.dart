import 'package:alekhlas_teachers/utils/colors.dart';
import 'package:alekhlas_teachers/utils/texts.dart';
import 'package:flutter/material.dart';

class CustomTabButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isSelected;
  const CustomTabButton(this.title, this.onPressed, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? primaryColor : whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: normal16Text(
        title,
        color: isSelected ? whiteColor : darkBlueColor,
      ),
    );
  }
}

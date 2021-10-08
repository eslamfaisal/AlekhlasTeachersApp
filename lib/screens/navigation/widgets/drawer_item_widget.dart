import 'package:flutter/material.dart';
import 'package:alekhlas_teachers/utils/common_functions.dart';
import 'package:alekhlas_teachers/utils/constants.dart';
import 'package:alekhlas_teachers/utils/extensions.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final String permission;
  final Color color;
  final VoidCallback function;
  final Icon icon;

  DrawerItemWidget(
    this.permission,
    this.title,
    this.color,
    this.function,
    this.icon,
  );

  //'assets/icons/facebook.png'
  //
  // tr("menu_string_key")

  @override
  Widget build(BuildContext context) {
    return hasThisPermission(permission) == false
        ? Container()
        : Container(
            color: color,
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Row(
              children: [
                icon,
                widthSpace(8),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ).onTap(function);
  }
}

import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String titleMessage;
  final double textFontSize;
  final Color textColor;
  final void Function() onTap;

  const CustomTile({super.key,
    required this.titleMessage,
    required this.onTap,
    this.textColor = Colors.white,
    this.textFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 230,
        alignment: Alignment.center,
        child: Text(
          titleMessage,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(color: textColor, fontSize: textFontSize),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double iconSize;
  final double textSize;
  final bool light;

  const AppLogo({
    super.key,
    this.iconSize = 36,
    this.textSize = 20,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize + 18,
          height: iconSize + 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2F80ED), Color(0xFF56CCF2)],
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            Icons.cloud_outlined,
            color: Colors.white,
            size: iconSize,
          ),
        ),
        const SizedBox(width: 11),
        Flexible(
          child: Text(
            'ONE CLOUD ENTERPRISE PLATFORM',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: light ? Colors.white : const Color(0xFF172B4D),
              fontSize: textSize,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

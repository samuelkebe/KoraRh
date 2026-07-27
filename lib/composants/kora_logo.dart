import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KoraLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const KoraLogo({super.key, this.size = 72, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 72 72" fill="none">
        <circle cx="36" cy="36" r="34" stroke="#E8A93E" stroke-width="2"/>
        <path d="M14 44 Q36 14 58 44" stroke="#E8A93E" stroke-width="2" fill="none"/>
        <path d="M20 48 Q36 24 52 48" stroke="#E8A93E" stroke-width="1.4" fill="none" opacity="0.7"/>
        <path d="M26 52 Q36 34 46 52" stroke="#E8A93E" stroke-width="1" fill="none" opacity="0.5"/>
      </svg>''',
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}


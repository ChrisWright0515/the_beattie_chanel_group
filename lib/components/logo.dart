import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  final double height;
  final double width;
  final String
      version; // Add a version parameter to select different PNG versions
  final double borderRadius;
  final List<BoxShadow> boxShadow;
  final Color backgroundColor;

  const Logo({
    super.key,
    required this.height,
    required this.width,
    required this.version,
    this.borderRadius = 0.0,
    this.boxShadow = const [],
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath;

    // Determine the asset path based on the version
    switch (version) {
      case 'icon':
        assetPath = 'assets/images/beattie_chanel_logo_icon_1224.png';
        break;
      default:
        assetPath = 'assets/logo_default.png';
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}



class LogoTextRow extends StatelessWidget {
  const LogoTextRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Logo(
          width: 50,
          height: 50,
          version: 'icon',
        ),
        const SizedBox(width: 10),
        Text(
          'Beattie-Chanel',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontFamily: GoogleFonts.prata().fontFamily),
        ),
      ],
    );
  }
}

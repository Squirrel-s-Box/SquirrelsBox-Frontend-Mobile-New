import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/helper/responsive.dart';
import '../../../../config/theme/colors.dart';

class PrincipalTitle extends StatelessWidget {
  final String title;
  const PrincipalTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AutoSizeText(title, style: GoogleFonts.openSans(
      fontSize: responsive.sp(25),
      color: AppColors.darkBlue,
      fontWeight: FontWeight.bold
    ),);
  }
}

class SecondaryTitle extends StatelessWidget {
  final String title;
  const SecondaryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AutoSizeText(title, style: GoogleFonts.openSans(
      fontSize: responsive.sp(17),
      color: AppColors.darkBlue,
      fontWeight: FontWeight.bold
    ),);
  }
}


class NormalText extends StatelessWidget {
  final String title;
  final bool isBold;
  const NormalText({super.key, required this.title, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AutoSizeText(title, style: GoogleFonts.openSans(
      fontSize: responsive.sp(17),
      color: AppColors.darkBlue,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal
    ),);
  }
}



class TinyText extends StatelessWidget {
  final String title;
  const TinyText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AutoSizeText( title, style: GoogleFonts.openSans(
      fontSize: responsive.sp(15),
      color: AppColors.darkBlue,
      fontWeight: FontWeight.normal
    ),);
  }
}


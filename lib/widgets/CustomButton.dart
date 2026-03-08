// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.icon,
//     this.bgColor,
//     this.fgColor,
//     this.gradient, // now optional
//   });

//   final String label;
//   final Color? bgColor;
//   final Color? fgColor;
//   final FaIcon? icon;
//   final Callback? onPressed;
//   final LinearGradient? gradient; // optional

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(5),
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(5),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 13),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             gradient: gradient,
//             color: gradient == null ? bgColor ?? Colors.blue : null,
//           ),
//           child: Center(
//             child:
//                 icon != null
//                     ? Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         FaIcon(icon!.icon, color: fgColor ?? Colors.white),
//                         const SizedBox(width: 10),
//                         Text(
//                           label,
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontFamily: GoogleFonts.poppins().fontFamily,
//                             fontWeight: FontWeight.bold,
//                             color: fgColor ?? Colors.white,
//                           ),
//                         ),
//                       ],
//                     )
//                     : Text(
//                       label,
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontFamily: GoogleFonts.poppins().fontFamily,
//                         fontWeight: FontWeight.bold,
//                         color: fgColor ?? Colors.white,
//                       ),
//                     ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notex_mobile/utils/helper.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.bgColor = Colors.transparent,
    this.fgColor,
    this.gradient,
    this.borderRadius = 5,
    this.verticalPadding = 13,
    this.fontSize = 17,
    this.horizontalPadding = 18,
  });

  final String label;
  late Color bgColor;
  final Color? fgColor;
  final IconData? icon;
  final VoidCallback? onPressed;
  final LinearGradient? gradient;
  final double borderRadius;
  final double verticalPadding;
  final double fontSize;
  final double horizontalPadding;

  TextStyle get _textStyle => GoogleFonts.poppins(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: fgColor ?? Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (bgColor != Colors.transparent) {
    } else {
      bgColor = isDark ? Colors.white : Colors.black;
    }
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: gradient,
          color: gradient == null ? bgColor : null,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max, // ✅ stretches to parent width
              children: [
                if (icon != null) ...[
                  FaIcon(
                    icon,
                    color: Helper.getOnBackgroundColor(bgColor),
                    size: fontSize + 2,
                  ),
                  const SizedBox(width: 10),
                ],
                Text(label, style: _textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

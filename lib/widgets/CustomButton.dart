import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.bgColor,
    this.fgColor,
    this.gradient, // now optional
  });

  final String label;
  final Color? bgColor;
  final Color? fgColor;
  final FaIcon? icon;
  final Callback? onPressed;
  final LinearGradient? gradient; // optional

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: gradient,
            color: gradient == null ? bgColor ?? Colors.blue : null,
          ),
          child: Center(
            child:
                icon != null
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(icon!.icon, color: fgColor ?? Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: fgColor ?? Colors.white,
                          ),
                        ),
                      ],
                    )
                    : Text(
                      label,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: fgColor ?? Colors.white,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

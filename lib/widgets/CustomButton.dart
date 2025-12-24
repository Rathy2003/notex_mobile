import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.label,this.onPressed,this.icon,this.bgColor,this.fgColor});

  final String label;
  final Color? bgColor;
  final Color? fgColor;
  final FaIcon? icon;
  final Callback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: ElevatedButton(
          onPressed: () => onPressed!(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 13),
            backgroundColor: bgColor ?? Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),

          ),
          child: icon != null ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon!.icon,
                color: fgColor ?? Colors.white,
              ),
              SizedBox(width: 17,),
              Text(
                  label,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                      color:  fgColor ?? Colors.white
                  )
              )
            ],
          ): Text(
              label,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  color:  fgColor ?? Colors.white
              )
          ),
      ),
    );
  }
}

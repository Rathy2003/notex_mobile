import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key,this.textController,this.hintText});
  final TextEditingController? textController;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: TextStyle(
          color: AppColors.textColor,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 18
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue
              )
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red
              )
          ),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.secondaryColor
      ),
    );
  }
}

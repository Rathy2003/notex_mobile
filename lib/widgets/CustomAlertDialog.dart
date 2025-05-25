import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key,required this.title,required this.content,this.cancelLabel,this.confirmLabel,required this.onConfirm});
  final String title;
  final String content;
  final String? cancelLabel;
  final String? confirmLabel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: ()=> Get.back(),
            child: Text( cancelLabel ?? "Cancel")
        ),
        TextButton(
            onPressed: onConfirm,
            child: Text(confirmLabel ?? "OK")
        )
      ],
    );
  }
}

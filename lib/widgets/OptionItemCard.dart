import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notex_mobile/utils/helper.dart';

class OptionItemCard extends StatelessWidget {
  const OptionItemCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.white : Colors.black.withValues(alpha: 0.5);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: bgColor,
            ),
            child: FaIcon(
              icon,
              size: 20,
              color: Helper.getOnBackgroundColor(
                bgColor,
              ).withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:notex_mobile/models/language.dart';

class LanguageSelectorSheet extends StatelessWidget {
  final List<Language> languages;
  final String selectedCode;
  final Function(Language) onSelected;

  const LanguageSelectorSheet({
    super.key,
    required this.languages,
    required this.selectedCode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 16),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'select_language'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),

          Divider(height: 1),

          // Language list
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final lang = languages[index];
              final isSelected = lang.code == selectedCode;

              return ListTile(
                onTap: () => onSelected(lang),
                leading: Text(lang.flag, style: TextStyle(fontSize: 28)),
                title: Text(
                  lang.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing:
                    isSelected
                        ? Icon(Icons.check_circle, color: Colors.blue)
                        : Icon(Icons.circle_outlined, color: Colors.grey[300]),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({
    super.key,
  });

  static String tag = 'select-language-page';

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  int selectedLanguageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Language',
          style: Typographies.heading4,
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguageIndex = 0;
              });
            },
            child: LanguageItem(
              icon: AppIcons.icEnglishLanguage,
              title: 'English',
              isSelected: selectedLanguageIndex,
              index: 0,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguageIndex = 1;
              });
            },
            child: LanguageItem(
              icon: AppIcons.icSpainLanguage,
              title: 'Spanish',
              isSelected: selectedLanguageIndex,
              index: 1,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguageIndex = 2;
              });
            },
            child: LanguageItem(
              icon: AppIcons.icSpainLanguage,
              title: 'Russian',
              isSelected: selectedLanguageIndex,
              index: 2,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguageIndex = 3;
              });
            },
            child: LanguageItem(
              icon: AppIcons.icEnglishLanguage,
              title: 'Uzbek',
              isSelected: selectedLanguageIndex,
              index: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageItem extends StatefulWidget {
  const LanguageItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.index,
  });

  final Widget icon;
  final String title;
  final int isSelected;
  final int index;

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13.5,
      ),
      height: 72,
      decoration: BoxDecoration(
        border: widget.index == widget.isSelected
            ? BoxBorder.all(color: MainPrimaryColor.primary500, width: 2)
            : BoxBorder.all(color: GreyScale.grayScale200, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          widget.icon,
          Text(
            widget.title,
            style: Typographies.heading6,
          ),
          const Spacer(),
          widget.index == widget.isSelected
              ? AppIcons.icProfileSubscribetionCheckboxSelected
              : const SizedBox(),
        ],
      ),
    );
  }
}
